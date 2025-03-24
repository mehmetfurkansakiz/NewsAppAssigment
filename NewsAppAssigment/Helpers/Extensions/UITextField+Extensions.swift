//
//  UITextField+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 22.03.2025.
//

import UIKit

import UIKit

extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPadding(left: CGFloat, right: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        if self.rightView == nil {
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
        }
    }
}

class PasswordTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        let button = UIButton(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        button.setImage(UIImage(named: "ic-show-icon"), for: .normal)
        button.setImage(UIImage(named: "ic-hide-icon"), for: .selected)
        buttonContainer.addSubview(button)
        
        rightView = buttonContainer
        rightViewMode = .always
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
}
