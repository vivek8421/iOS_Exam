//
//  C.swift
//  iOS_Exam
//
//  Created by Neosoft on 26/08/24.
//

import UIKit

extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    return nil
  }
}
