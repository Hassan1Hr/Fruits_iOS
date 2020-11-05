//
//  MoreClasses.swift
//  Tourist-Guide
//
//  Created by Bassam Ramadan on 11/8/19.
//  Copyright © 2019 Bassam Ramadan. All rights reserved.
//

import UIKit

class Shadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
class ViewShadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}

class TextFieldShadow: UITextField {
    
    let padding = UIEdgeInsets(top: 0,left: 15,bottom: 0,right: 15)
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
class TextViewShadow: UITextView {
    override func awakeFromNib() {
        super.awakeFromNib()
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
    
}
class ButtonShadow: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
class imageShadow: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        clipsToBounds = true
    }
}

class cellShadow: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
}

class dots: UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        let p0 = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        let p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}
class border: UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor(named: "gray")?.cgColor
        self.layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
class borderYellow: UIView{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor(named: "yellow")?.cgColor
        self.layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.70
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
    }
}
extension UIView{
    func border(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "yellow")?.cgColor
        backgroundColor = nil
        self.layer.cornerRadius = 5
    }
    func removeBorder(){
        self.layer.borderWidth = 0
        backgroundColor = UIColor(named: "gray")
        self.layer.cornerRadius = 5
    }
    func removeTextFieldBorder(){
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
    }
}
extension String {
    //Converts String to Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    //Converts String to Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    //Converts String to Bool
    public func toBool() -> Bool? {
        return (self as NSString).boolValue
    }
}
extension String {
    // formatting text for currency textField
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
