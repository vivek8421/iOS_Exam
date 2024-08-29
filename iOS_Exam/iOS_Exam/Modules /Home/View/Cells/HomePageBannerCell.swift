//
//  HomePageBannerCell.swift
//  iOS_Exam
//

import UIKit

class HomePageBannerCell: UITableViewCell {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var teams: [Team] = [] {
        didSet {
            pageControl.numberOfPages = teams.count
        }
    }
    var didChangeTeam: ((_ index: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageControl.currentPage = 0
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        let nib = UINib(nibName: Constants.bannerCell, bundle: nil)
        bannerCollectionView.register(nib, forCellWithReuseIdentifier: Constants.bannerCell)
    }
}


extension HomePageBannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.bannerCell, for: indexPath) as? BannerCell else {
            fatalError()
        }
        cell.team = teams[indexPath.row]
        return cell
    }
}


extension HomePageBannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  = bannerCollectionView.bounds.height
        let width  = bannerCollectionView.bounds.width
        return CGSize(width: width, height: height)
    }
}


extension HomePageBannerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let index = collectionView.visibleCurrentCellIndexPath {
            pageControl.currentPage = index.row
            didChangeTeam?(index.row)
        }
    }
}
