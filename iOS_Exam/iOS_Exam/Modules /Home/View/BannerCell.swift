//
//  BannerCell.swift
//  iOS_Exam
//


import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var imageString: String?{
        didSet{
            guard let imageString else{return}
           // imgView.setImage(urlString: imageString)
        }
    }

}
