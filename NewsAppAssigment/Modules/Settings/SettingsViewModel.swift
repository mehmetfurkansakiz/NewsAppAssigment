//
//  SettingsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 18.03.2025.
//

final class SettingsViewModel: SettingsViewModelProtocol {
    weak var delegate: SettingsViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    private var isAdmin: Bool = false
    
    private(set) var visibleSections: [SettingsSection] = [] {
        didSet {
            notify(.updateTableView)
        }
    }
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
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
        case .signOut:
            signOut()
        }
    }
    
    func checkAdminStatus() {
        userRepository.checkIsAdmin { [weak self] isAdmin in
            guard let self = self else { return }
            self.isAdmin = isAdmin
            self.updateVisibleSections()
        }
    }
    
    private func updateVisibleSections() {
        visibleSections = isAdmin ? SettingsSection.allCases : SettingsSection.allCases.filter { $0 != .admin }
    }
    
    private func signOut() {
        let result = userRepository.signOut()
        
        switch result {
        case .success:
            notify(.signOutSuccess)
        case .failure(let error):
            notify(.showError(error.localizedDescription))
        }
    }
    
    private func notify(_ output: SettingsViewModelOutput) {
        delegate?.handleSettingsViewModelOutput(output)
    }
    
    private func navigate(to route: SettingsRouter) {
        delegate?.navigate(to: route)
    }
}
