//
//  TabBarController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 13.03.2025.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
}

// MARK: - Private Methods
private extension TabBarController {
    func setupTabs() {
        let homeVC = createNav(with: "News", and: UIImage(named: "news-icon"), viewController: HomeBuilder.make(with: HomeViewModel()))
        let settingsVC = createNav(with: "Settings", and: UIImage(named: "settings-icon"), viewController: SettingsViewController())
        setViewControllers([homeVC, settingsVC], animated: false)
    }
    
    func createNav(
        with title: String,
        and image: UIImage?,
        viewController: UIViewController
    ) -> UINavigationController {
        let controller = UINavigationController(rootViewController: viewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        viewController.title = title
        controller.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.largeTitleDisplayMode = .always
        return controller
    }
}
