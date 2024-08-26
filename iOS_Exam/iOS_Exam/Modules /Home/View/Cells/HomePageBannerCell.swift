//
//  HomePageBannerCell.swift
//  iOS_Exam
//

import UIKit

class HomePageBannerCell: UITableViewCell {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
   // let viewModel = HomeViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5//viewModel.bannerImages.count
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.register(BannerCell.nib, forCellWithReuseIdentifier: BannerCell.id)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension HomePageBannerCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5 //viewModel.bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.id, for: indexPath) as? BannerCell else {
            fatalError()
        }
        //cell.imageString = viewModel.bannerImages[indexPath.row]
        return cell
    }
}


extension HomePageBannerCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  = bannerCollectionView.bounds.height
        let width  = bannerCollectionView.bounds.width
        return CGSize(width: width, height: height)
    }
}


extension HomePageBannerCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let index = collectionView.visibleCurrentCellIndexPath {
            pageControl.currentPage = index.row
        }
        
    }
}

extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    return nil
  }
}
