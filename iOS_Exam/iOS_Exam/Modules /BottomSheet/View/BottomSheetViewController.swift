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
    
    var viewModel: BottomSheetViewModelProtocol = BottomSheetViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }

    private func bindData() {
        lblTotalPlayer.text = "Players count \(viewModel.player.count)"
        let result = viewModel.topThreeCharacters().characterOccurence ?? []
        
        if result.count >= 3 {
            lblFirst.text = viewModel.getCharacterCountString(result: result[0])
            lblSecond.text = viewModel.getCharacterCountString(result: result[1])
            lblThird.text = viewModel.getCharacterCountString(result: result[2])
        }
    }
}


