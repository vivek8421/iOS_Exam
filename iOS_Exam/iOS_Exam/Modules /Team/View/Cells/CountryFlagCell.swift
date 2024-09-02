//
//  HomePageBannerCell.swift
//  iOS_Exam
//

import UIKit

class CountryFlagCell: UITableViewCell {
    
    @IBOutlet weak var flagCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var teams: [Team] = [] {
        didSet {
            pageControl.numberOfPages = teams.count
        }
    }
    var didChangeTeam: ((_ index: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupViews() {
        pageControl.currentPage = 0
        flagCollectionView.dataSource = self
        flagCollectionView.delegate = self
        let nib = UINib(nibName: Constants.countryFlagCollectionCell, bundle: nil)
        flagCollectionView.register(nib, forCellWithReuseIdentifier: Constants.countryFlagCollectionCell)
    }
}


extension CountryFlagCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = flagCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.countryFlagCollectionCell, for: indexPath) as? CountryFlagCollectionCell else {
            return UICollectionViewCell()
        }
        cell.teamImageURL = teams[indexPath.row].teamImageURL
        return cell
    }
}


extension CountryFlagCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height  = flagCollectionView.bounds.height
        let width  = flagCollectionView.bounds.width
        return CGSize(width: width, height: height)
    }
}


extension CountryFlagCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.visibleCells.first,
           let indexpath =  collectionView.indexPath(for: cell) {
            pageControl.currentPage = indexpath.row
            didChangeTeam?(indexpath.row)
        }
    }
}
