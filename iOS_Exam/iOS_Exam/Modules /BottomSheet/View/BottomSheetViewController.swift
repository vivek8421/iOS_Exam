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
    
    private let viewModel = BottomSheetViewModel()
    var player: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    private func configuration() {
        let playersNames = viewModel.getOnlyPlayer(playeres: player)
        let result = viewModel.topThreeCharacters(in: playersNames).characterOccurence
        
        if result.count >= 3 {
            lblFirst.text = viewModel.getString(result: result[0])
            lblSecond.text = viewModel.getString(result: result[1])
            lblThird.text = viewModel.getString(result: result[2])
        }
    }
}


