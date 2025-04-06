//
//  AdminNewsViewModel.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 3.04.2025.
//

final class AdminNewsViewModel: AdminNewsViewModelProtocol {
    weak var delegate: AdminNewsViewModelDelegate?
    
    func didSelectSetting(at index: Int) {
        guard let action = AdminActions(rawValue: index) else { return }
        
        switch action {
        case .addNews:
            navigate(to: .addNews(AddNewsViewModel()))
        case .editNews:
            notify(.editNews)
        case .deleteNews:
            notify(.deleteNews)
        case .statistics:
            notify(.statistics)
        case .users:
            notify(.users)
        }
    }
    
    private func notify(_ output: AdminNewsViewModelOutput) {
        delegate?.handleAdminNewsViewModelOutput(output)
    }
    
    private func navigate(to route: AdminNewsRouter) {
        delegate?.navigate(to: route)
    }
}
