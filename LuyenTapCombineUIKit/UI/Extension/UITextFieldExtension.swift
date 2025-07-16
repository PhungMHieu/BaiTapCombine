//
//  UITextFieldExtension.swift
//  TestThuDelegate
//
//  Created by Admin on 29/6/25.
//

import Foundation

import UIKit

extension UITextField {
    func setBorder(radius: CGFloat, color: UIColor, width: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}

