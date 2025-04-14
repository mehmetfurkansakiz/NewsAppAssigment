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
    // Alert Extension
    enum AlertType {
        case error
        case success
        case warning
        case info
        
        var title: String {
            switch self {
            case .error: return "Error!"
            case .success: return "Success!"
            case .warning: return "Warning!"
            case .info: return "Info"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .error: return .destructive
            case .success: return .default
            case .warning: return .default
            case .info: return .default
            }
        }
    }
    
    func showAlert(type: AlertType = .info,
                   message: String,
                   buttonTitle: String = "OK",
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: type.title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle,
                                   style: type.style) { _ in
            completion?()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // Convenience funcs
    func showError(message: String, completion: (() -> Void)? = nil) {
        showAlert(type: .error, message: message, completion: completion)
    }
    
    func showSuccess(message: String, completion: (() -> Void)? = nil) {
        showAlert(type: .success, message: message, completion: completion)
    }
    
    func showWarning(message: String, completion: (() -> Void)? = nil) {
        showAlert(type: .warning, message: message, completion: completion)
    }
    
    func showInfo(message: String, completion: (() -> Void)? = nil) {
        showAlert(type: .info, message: message, completion: completion)
    }
}
