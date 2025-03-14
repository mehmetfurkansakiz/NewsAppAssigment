//
//  SplashViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 11.03.2025.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "newspaper-icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let logoTextLabel: UILabel = {
        let label = UILabel()
        label.text = "News App"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "6C63FF")
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        navigateToTabBar()
    }
}

// MARK: - Private Methods
private extension SplashViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(logoImageView)
        view.addSubview(logoTextLabel)
    }
    
    func configureLayout() {
        logoImageView.setupAnchors(
            leading: view.leadingAnchor,    paddingLeading: 32,
            trailing: view.trailingAnchor, paddingTrailing: 32,
            centerY: view.centerYAnchor
        )

        
        logoTextLabel.setupAnchors(
            top: logoImageView.bottomAnchor, paddingTop: -64,
            leading: logoImageView.leadingAnchor,
            trailing: logoImageView.trailingAnchor
        )
    }
    
    func navigateToTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard self != nil else { return }
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            let tabBarController = TabBarController()
             
            sceneDelegate.window?.rootViewController = tabBarController
        }
     }
}

#Preview {
    SplashViewController()
}
