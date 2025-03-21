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
            delegate?.handleSettingsViewModelOutput(.showAdminPanel)
        case .notification:
            delegate?.handleSettingsViewModelOutput(.showNotificationSettings)
        case .rateUs:
            delegate?.handleSettingsViewModelOutput(.rateApp)
        case .privacyPolicy:
            delegate?.handleSettingsViewModelOutput(.showPrivacyPolicy)
        case .termsOfService:
            delegate?.handleSettingsViewModelOutput(.showTermsOfService)
        }
    }
    
    private func notify(_ output: SettingsViewModelOutput) {
        delegate?.handleSettingsViewModelOutput(output)
    }
}
