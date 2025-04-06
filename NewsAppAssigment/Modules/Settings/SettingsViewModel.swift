//
//  SettingsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 18.03.2025.
//

final class SettingsViewModel: SettingsViewModelProtocol {
    weak var delegate: SettingsViewModelDelegate?
    
    var settings: [Settings] {
        return Settings.allCases
    }
    
    func didSelectSetting(at index: Int) {
        guard let setting = Settings(rawValue: index) else { return }
        
        switch setting {
        case .admin:
            navigate(to: .adminNews(AdminNewsViewModel()))
        case .notification:
            notify(.showNotificationSettings)
        case .rateUs:
            notify(.rateApp)
        case .privacyPolicy:
            notify(.showPrivacyPolicy)
        case .termsOfService:
            notify(.showTermsOfService)
        }
    }
    
    private func notify(_ output: SettingsViewModelOutput) {
        delegate?.handleSettingsViewModelOutput(output)
    }
    
    private func navigate(to route: SettingsRouter) {
        delegate?.navigate(to: route)
    }
}
