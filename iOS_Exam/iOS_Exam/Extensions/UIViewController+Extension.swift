//
//  UIViewController+Extension.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import UIKit

extension UIViewController {
    func presentBottomSheet(height: CGFloat,viewController: UIViewController){
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                if #available(iOS 16.0, *) {
                    sheet.preferredCornerRadius = 24
                    sheet.detents = [.custom(resolver: { context in
                        return height
                    })]
                }
            }
        }
        present(nav, animated: true, completion: nil)
    }
    
    func presentBottomSheet(viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        self.present(viewController, animated: true)
    }
}
