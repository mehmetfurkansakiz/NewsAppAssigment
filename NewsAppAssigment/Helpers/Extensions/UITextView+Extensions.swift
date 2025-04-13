//
//  UITextView+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 6.04.2025.
//

import UIKit

extension UITextView {
    func setPadding(_ padding: UIEdgeInsets) {
        self.textContainerInset = padding
    }
    
    func setHorizontalPadding(_ padding: CGFloat) {
        self.textContainer.lineFragmentPadding = padding
        self.textContainerInset = UIEdgeInsets(top: 8, left: padding - 5, bottom: 8, right: padding - 5)
    }
}
