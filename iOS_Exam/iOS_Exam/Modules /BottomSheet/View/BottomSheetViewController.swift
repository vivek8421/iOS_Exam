//
//  BottomSheetViewController.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    
    @IBOutlet weak var lblTotalPlayer: UILabel!
    
    private let viewModel = BottomSheetViewModel()
    var player: [Player] = [] {
        didSet {
            viewModel.player = player
        }
    }
    
    override func viewDidLoad() {
        bindData()
    }

    private func bindData() {
        lblTotalPlayer.text = "Players count \(player.count)"
        let result = viewModel.topThreeCharacters().characterOccurence
        
        if result.count >= 3 {
            lblFirst.text = viewModel.getString(result: result[0])
            lblSecond.text = viewModel.getString(result: result[1])
            lblThird.text = viewModel.getString(result: result[2])
        }
    }
}


