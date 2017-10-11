//
//  PCFloatingTextField.swift
//  PCFloatingTextField
//
//  Created by Pradeep Chauhan on 10/11/17.
//  Copyright © 2017 Pradeep Chauhan. All rights reserved.
//

import UIKit

protocol PCFloatingDelegate {
    func PCFloatingTextFieldDidBeginEditing(_ textField: UITextField)
    func PCFloatingTextFieldDidEndEditing(_ textField: UITextField)
    func PCFloatingTextFieldShouldReturn(_ textField: UITextField)
    func PCFloatingTextFieldShouldClear(_ textField: UITextField)
    func PCFloatingTextFieldshouldChangeCharactersIn(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
}

@IBDesignable
public class PCFloatingTextFiled: UITextField, UITextFieldDelegate {
    
    @IBInspectable public var animationDuration: Double = 0.5
    @IBInspectable public var subjectColor: UIColor = UIColor.black
    @IBInspectable public var underLineColor: UIColor = UIColor.black
    
    fileprivate let placeholderLabelFontSize: CGFloat = 12.0
    fileprivate var placeholderLabel: UILabel?
    fileprivate var titlePlaceholder: String?
    var PCDelegate:PCFloatingDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override public func draw(_ rect: CGRect) {
        drawUnderLine()
        createPlaceholderLabel()
        self.clipsToBounds = false
        self.borderStyle = .none
    }
    
    fileprivate func drawUnderLine() {
        let underLineView = UIView(frame: CGRect(x: 0, y: frame.size.height - 1, width: frame.size.width, height: 1))
        underLineView.backgroundColor = underLineColor
        self.addSubview(underLineView)
    }
    
    fileprivate func createPlaceholderLabel() {
        let origin = self.frame.origin
        let label = UILabel(frame: CGRect(x: origin.x, y: origin.y, width: self.frame.size.width, height: 15.0))
        label.center = self.center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: self.placeholderLabelFontSize)
        label.textColor = subjectColor
        
        if let superView = self.superview {
            superView.insertSubview(label, belowSubview: self)
        }
        self.placeholderLabel = label
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let placeholderLabel = self.placeholderLabel, self.text == "" {
            if placeholderLabel.alpha == 0 {
                placeholderLabel.alpha = 1
            }
            
            if self.placeholder == "" {
                self.titlePlaceholder = placeholderLabel.text
            } else {
                self.titlePlaceholder = self.placeholder
            }
            
            self.placeholder = ""
            
            let frame = placeholderLabel.frame
            UIView.animate(withDuration: animationDuration, animations: {
                placeholderLabel.text = self.titlePlaceholder
                placeholderLabel.font = UIFont.systemFont(ofSize: self.placeholderLabelFontSize)
                placeholderLabel.textColor = self.subjectColor
                placeholderLabel.frame.origin.y = frame.origin.y - placeholderLabel.frame.size.height - (self.frame.size.height / 2 - frame.size.height / 2)
            }, completion: { (isComplete) in
                
            })
        }
        self.PCDelegate?.PCFloatingTextFieldDidBeginEditing(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let placeholderLabel = self.placeholderLabel, self.text == "" {
            let frame = placeholderLabel.frame
            UIView.animate(withDuration: animationDuration, animations: {
                
                placeholderLabel.alpha = 1
                placeholderLabel.textColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0.0980392, alpha: 0.22)
                
                placeholderLabel.frame.origin.y = frame.origin.y + placeholderLabel.frame.size.height + (self.frame.size.height / 2 - frame.size.height / 2)
                if let pointSize = self.font?.pointSize {
                    placeholderLabel.font = UIFont.systemFont(ofSize: pointSize)
                }
                
            }, completion: { (isComplete) in
                self.placeholder = self.titlePlaceholder
                placeholderLabel.alpha = 0
            })
        } else {
            self.PCDelegate?.PCFloatingTextFieldDidEndEditing(textField)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.PCDelegate?.PCFloatingTextFieldShouldReturn(textField)
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.PCDelegate?.PCFloatingTextFieldShouldClear(textField)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.PCDelegate?.PCFloatingTextFieldshouldChangeCharactersIn(textField, shouldChangeCharactersIn: range, replacementString: string)
        return true
    }
}

