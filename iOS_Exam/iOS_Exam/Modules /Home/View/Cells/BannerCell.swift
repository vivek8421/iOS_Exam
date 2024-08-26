//
//  BannerCell.swift
//  iOS_Exam
//


import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    var team: Team? {
        didSet {
            guard let team else { return }
            imgView.image = UIImage(named: team.teamImageURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
