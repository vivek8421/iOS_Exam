//
//  UIViewController+Extension.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import UIKit

extension UIViewController {
    func presentBottomSheet(height: CGFloat, viewController: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.custom(resolver: { _ in height })]
                sheet.preferredCornerRadius = 24
            }
        }
        present(nav, animated: true, completion: nil)
    }
}
