//
//  DesignableButton.swift
//  Apptunes
//
//  Created by Marwin Carino on 8/22/21.
//

import Foundation
import UIKit

@IBDesignable
class DesignableButton: UIButton, RefreshableViewProtocol {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard animatesWhenTapped else { return true }
        self.animateTouchDown()
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard animatesWhenTapped else { return }
        self.animateTouchUp()
    }
    
    override func cancelTracking(with event: UIEvent?) {
        guard animatesWhenTapped else { return }
        self.animateTouchUp()
    }
    
    @IBInspectable
    var animatesWhenTapped: Bool = true
    
    @IBInspectable
    var activeBackgroundColor: UIColor = .clear {
        didSet {
            self.backgroundColor = activeBackgroundColor
        }
    }
    
    @IBInspectable
    var inactiveBackgroundColor: UIColor = .clear {
        didSet {
            self.backgroundColor = inactiveBackgroundColor
        }
    }
    
    @IBInspectable
    var activeTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(activeTextColor, for: .selected)
        }
    }
    
    @IBInspectable
    var inactiveTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(inactiveTextColor, for: .normal)
        }
    }
    
    @IBInspectable
    var activeImage: UIImage? {
        didSet {
            self.setImage(activeImage, for: .selected)
        }
    }
    
    @IBInspectable
    var inactiveImage: UIImage? {
        didSet {
            self.setImage(inactiveImage, for: .normal)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
            self.refresh()
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = activeBackgroundColor
                self.setTitleColor(activeTextColor, for: .selected)
                self.setImage(activeImage, for: .selected)
            } else {
                self.backgroundColor = inactiveBackgroundColor
                self.setTitleColor(inactiveTextColor, for: .normal)
                self.setImage(inactiveImage, for: .normal)
            }
        }
    }
}

extension DesignableButton: BorderProtocol {
    @IBInspectable
    var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
            self.refresh()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
            self.refresh()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
            self.refresh()
        }
    }
}

extension DesignableButton: ShadowProtocol {
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            self.refresh()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
            self.refresh()
        }
    }
    
    @IBInspectable
    var shadowOpacity: CGFloat {
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
        set {
            self.layer.shadowOpacity = Float(newValue)
            self.refresh()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
            self.refresh()
        }
    }
}
