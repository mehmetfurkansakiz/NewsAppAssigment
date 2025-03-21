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
        configureAppearance()
    }
}

// MARK: - Private Methods
private extension TabBarController {
    func setupTabs() {
        let homeVC = createNav(with: "News", and: UIImage(named: "news-icon"), viewController: HomeBuilder.make(with: HomeViewModel()))
        let settingsVC = createNav(with: "Settings", and: UIImage(named: "settings-icon"), viewController: SettingsBuilder.make(with: SettingsViewModel()))
        setViewControllers([homeVC, settingsVC], animated: false)
    }
    
    func configureAppearance() {
        // MARK: - tab bar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "6C63FF")
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(named: "FBFBFB")!.withAlphaComponent(0.6)
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FBFBFB")!.withAlphaComponent(0.6)]
        itemAppearance.selected.iconColor = UIColor(named: "FBFBFB")
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FBFBFB")!]
        
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance
        
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        // MARK: - navigation bar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "6C63FF")
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FBFBFB")!]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "FBFBFB")!]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = UIColor(named: "303030")
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

#Preview {
    TabBarController()
}
