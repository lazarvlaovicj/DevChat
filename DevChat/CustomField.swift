//
//  CustomField.swift
//  DevChat
//
//  Created by PRO on 4/27/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

@IBDesignable
class CustomField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder?.string : ""
            let str = NSAttributedString(string: rawString!, attributes: [NSForegroundColorAttributeName: placeholderColor!])
            attributedPlaceholder = str
        }
    }
    
}
