//
//  TeamPlayerCell.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import UIKit

class TeamPlayerCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.borderColor = UIColor.systemGray5.cgColor
            bgView.layer.borderWidth = 1.0
            bgView.layer.cornerRadius = 16.0
            bgView.layer.masksToBounds = true
        }
    }
    
    var player: Player? {
        didSet {
            guard let player else { return }
            lblTitle.text = player.name
            lblSubTitle.text = player.role.rawValue
            if let playerImg = UIImage(named: player.imageURL) {
                profileImg.image = playerImg
            } else {
                profileImg.image = UIImage(named: "no-image")
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
