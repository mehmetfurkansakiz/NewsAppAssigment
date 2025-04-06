//
//  AdminNewsContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 3.04.2025.
//

import UIKit

protocol AdminNewsViewModelProtocol {
    var delegate: AdminNewsViewModelDelegate? { get set }
    func didSelectSetting(at index: Int)
}

protocol AdminNewsViewModelDelegate: AnyObject {
    func handleAdminNewsViewModelOutput(_ output: AdminNewsViewModelOutput)
    func navigate(to route: AdminNewsRouter)
}

enum AdminNewsViewModelOutput {
    case showError(String)
    case editNews
    case deleteNews
    case statistics
    case users
}

enum AdminNewsRouter {
    case addNews(AddNewsViewModel)
}

enum AdminActions: Int, CaseIterable {
    case addNews = 0
    case editNews = 1
    case deleteNews = 2
    case statistics = 3
    case users = 4
    
    var title: String {
        switch self {
        case .addNews: return "Add News"
        case .editNews: return "Edit News"
        case .deleteNews: return "Delete News"
        case .statistics: return "Statistics"
        case .users: return "Users"
        }
    }
    
    var icon: String {
        switch self {
        case .addNews:
            return "plus.circle.fill"
        case .editNews:
            return "pencil.circle.fill"
        case .deleteNews:
            return "trash.circle.fill"
        case .statistics:
            return "chart.bar.fill"
        case .users:
            return "person.2.fill"
        }
    }
    
    var color: UIColor {
        switch self {
        case .addNews:
            return UIColor(named: "6C63FF") ?? .systemBlue
        case .editNews:
            return UIColor(named: "303030") ?? .darkGray
        case .deleteNews:
            return UIColor(named: "A9A9A9") ?? .gray
        case .statistics:
            return UIColor(named: "181818") ?? .black
        case .users:
            return UIColor(named: "6C63FF") ?? .systemBlue
        }
    }
}
