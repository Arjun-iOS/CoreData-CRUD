//
//  CustomView.swift
//  DemoCoreData
//
//  Created by Arjun on 09/02/21.
//  Copyright © 2021 Arjun. All rights reserved.
//




import Foundation

import UIKit

class CustomView: UIView {
    
    
//border Color
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
//border width
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
//border Bound
    @IBInspectable var borderBound: CGFloat = 10 {
        didSet {
            layer.cornerRadius = borderBound
         }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 0.5 * bounds.size.width
        //clipsToBounds = true
    }
}

class customLabel: UILabel {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    

    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderBound: CGFloat = 10 {
        didSet {
            layer.cornerRadius = borderBound
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 0.5 * bounds.size.width
        //clipsToBounds = true
    }
}
class customImage: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderBound: CGFloat = 10 {
        didSet {
            layer.cornerRadius = borderBound
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 0.5 * bounds.size.width
        //clipsToBounds = true
    }
}
class customButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderBound: CGFloat = 10 {
        didSet {
            layer.cornerRadius = borderBound
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 0.5 * bounds.size.width
        //clipsToBounds = true
    }
}


class customTextField: UITextField {
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
        
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderBound: CGFloat = 10 {
        didSet {
            layer.cornerRadius = borderBound
        }
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 0.5 * bounds.size.width
        //clipsToBounds = true
    }
}
