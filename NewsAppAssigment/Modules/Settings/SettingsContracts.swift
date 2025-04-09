//
//  SettingsContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 18.03.2025.
//

protocol SettingsViewModelProtocol {
    var delegate: SettingsViewModelDelegate? { get set }
    var visibleSections: [SettingsSection] { get }
    func didSelectSetting(at index: Int)
    func checkAdminStatus()
}

protocol SettingsViewModelDelegate: AnyObject {
    func handleSettingsViewModelOutput(_ output: SettingsViewModelOutput)
    func navigate(to route: SettingsRouter)
}

enum SettingsViewModelOutput {
    case updateTableView
    case showNotificationSettings
    case rateApp
    case showPrivacyPolicy
    case showTermsOfService
    case signOutSuccess
    case showError(String)
}

enum SettingsRouter {
    case adminNews(AdminNewsViewModel)
}

enum SettingsSection: Int, CaseIterable {
    case admin
    case notifications
    case others
    case account
    
    var title: String {
        switch self {
        case .admin: return "Admin"
        case .notifications: return "Notifications"
        case .others: return "Others"
        case .account: return "Account"
        }
    }
    
    var settings: [Settings] {
        switch self {
        case .admin:
            return [.admin]
        case .notifications:
            return [.notification]
        case .others:
            return [.rateUs, .privacyPolicy, .termsOfService]
        case .account:
            return [.signOut]
        }
    }
}

enum Settings: Int, CaseIterable {
    case admin = 0
    case notification = 1
    case rateUs = 2
    case privacyPolicy = 3
    case termsOfService = 4
    case signOut = 5
    
    var title: String {
        switch self {
        case .admin: return "Admin mode"
        case .notification: return "Notifications"
        case .rateUs: return "Rate us"
        case .privacyPolicy: return "Privacy policy"
        case .termsOfService: return "Terms of service"
        case .signOut: return "Sign Out"
        }
    }
    
    var iconName: String {
        switch self {
        case .admin: return "person.fill"
        case .notification: return "bell.fill"
        case .rateUs: return "star.fill"
        case .privacyPolicy: return "lock.fill"
        case .termsOfService: return "doc.text.fill"
        case .signOut: return "rectangle.portrait.and.arrow.right"
        }
    }
}
