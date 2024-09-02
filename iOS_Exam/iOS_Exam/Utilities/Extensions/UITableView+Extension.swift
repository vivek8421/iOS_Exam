//
//  e.swift
//  iOS_Exam
//
//  Created by Neosoft on 02/09/24.
//

import UIKit

extension UITableView {
    func addNoDataView(message: String){
        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.center = self.center
        self.backgroundView = label
    }
    
}
