//
//  UIView+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 11.03.2025.
//

import UIKit

extension UIView {
    func setupAnchors(
        top: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil,
        paddingBottom: CGFloat = 0,
        leading: NSLayoutXAxisAnchor? = nil,
        paddingLeading: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingTrailing: CGFloat = 0,
        safeArea: Bool = false,
        centerX: NSLayoutXAxisAnchor? = nil,
        paddingCenterX: CGFloat = 0,
        centerY: NSLayoutYAxisAnchor? = nil,
        paddingCenterY: CGFloat = 0,
        width: CGFloat = 0,
        height: CGFloat = 0,
        dynamicWidth: NSLayoutDimension? = nil,
        dynamicHeight: NSLayoutDimension? = nil,
        aspectRatio: CGFloat? = nil,
        priority: UILayoutPriority = .required
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            let anchor = safeArea ? superview?.safeAreaLayoutGuide.topAnchor ?? top : top
            let constraint = topAnchor.constraint(equalTo: anchor, constant: paddingTop)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let bottom = bottom {
            let anchor = safeArea ? superview?.safeAreaLayoutGuide.bottomAnchor ?? bottom : bottom
            let constraint = bottomAnchor.constraint(equalTo: anchor, constant: -paddingBottom)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let leading = leading {
            let anchor = safeArea ? superview?.safeAreaLayoutGuide.leadingAnchor ?? leading : leading
            let constraint = leadingAnchor.constraint(equalTo: anchor, constant: paddingLeading)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let trailing = trailing {
            let anchor = safeArea ? superview?.safeAreaLayoutGuide.trailingAnchor ?? trailing : trailing
            let constraint = trailingAnchor.constraint(equalTo: anchor, constant: -paddingTrailing)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let centerX = centerX {
            let constraint = centerXAnchor.constraint(equalTo: centerX, constant: paddingCenterX)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let centerY = centerY {
            let constraint = centerYAnchor.constraint(equalTo: centerY, constant: paddingCenterY)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if width != 0 {
            let constraint = widthAnchor.constraint(equalToConstant: width)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if height != 0 {
            let constraint = heightAnchor.constraint(equalToConstant: height)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let dynamicWidth = dynamicWidth {
            let constraint = widthAnchor.constraint(equalTo: dynamicWidth)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let dynamicHeight = dynamicHeight {
            let constraint = heightAnchor.constraint(equalTo: dynamicHeight)
            constraint.priority = priority
            constraint.isActive = true
        }
        
        if let aspectRatio = aspectRatio {
            let constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio)
            constraint.priority = priority
            constraint.isActive = true
        }
    }
}
