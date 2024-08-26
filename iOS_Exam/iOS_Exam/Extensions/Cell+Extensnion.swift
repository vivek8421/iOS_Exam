//
//  Cell+Extensnion.swift
//  iOS_Exam
//


import UIKit

protocol IdNibProtocol {
    static var id: String { get }
    static var nib: UINib { get }
}

extension IdNibProtocol {
    static var id: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}

extension UIViewController: IdNibProtocol { }

extension UIView: IdNibProtocol { }




