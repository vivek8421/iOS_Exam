//
//  BannerCell.swift
//  iOS_Exam
//


import UIKit

class CountryFlagCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    var teamImageURL: String? {
        didSet {
            guard let teamImageURL else { return }
            imgView.image = UIImage(named: teamImageURL)
        }
    }
}
