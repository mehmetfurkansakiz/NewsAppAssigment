//
//  UIViewController+Extensions.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 26.03.2025.
//

import Foundation
import UIKit

extension UIViewController {
    static let activityIndicatorTag = 111
    static let blurViewTag = 112
    
    func showLoadingIndicator() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }),
              window.viewWithTag(Self.activityIndicatorTag) == nil else { return }
        
        // Blur View
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = window.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.tag = Self.blurViewTag
        
        blurView.alpha = 0.1
        window.addSubview(blurView)
        
        // Activity Indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tag = Self.activityIndicatorTag
        activityIndicator.center = CGPoint(x: window.bounds.midX, y: window.bounds.midY)
        activityIndicator.color = UIColor(named: "6C63FF")
        activityIndicator.startAnimating()
        
        window.addSubview(activityIndicator)
    }
    
    func hideLoadingIndicator() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }),
           let activityIndicator = window.viewWithTag(Self.activityIndicatorTag) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if let blurView = window.viewWithTag(Self.blurViewTag) as? UIVisualEffectView {
                blurView.removeFromSuperview()
            }
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func navigateToWithAnimation(to controller: UIViewController, transition: UIView.AnimationOptions = .transitionCrossDissolve, duration: TimeInterval = 0.5) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            UIView.transition(with: self.view.window!, duration: duration, options: transition, animations: {
                sceneDelegate.window?.rootViewController = controller
            })
        }
    }
}
