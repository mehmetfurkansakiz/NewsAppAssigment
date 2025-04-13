//
//  ContentListContracts.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import Foundation

protocol ContentListViewModelProtocol {
    var delegate: ContentListViewModelDelegate? { get set }
    var mode: ListMode { get }
    var sections: [ContentListSection] { get }
    var filteredNews: [News] { get }
    func fetchNews()
    func filterNews(with query: String)
    func deleteNews(_ news: News)
    func confirmDelete(_ news: News)
    func selectNews(_ news: News)
}

protocol ContentListViewModelDelegate: AnyObject {
    func handleContentListViewModelOutput(_ output: ContentListViewModelOutput)
    func navigate(to route: ContentListRouter)
}

enum ContentListViewModelOutput {
    case showLoading
    case hideLoading
    case showError(String)
    case reloadData
    case reloadNewsSection
    case deleteSuccess(String)
    case showDeleteConfirmation(News)
}

enum ContentListRouter {
    case updateNews(UpdateNewsViewModel)
}

enum ContentListSection: Int, CaseIterable {
    case search
    case news
    
    var title: String? {
        switch self {
        case .search: return nil
        case .news: return nil
        }
    }
}

enum ListMode {
    case update
    case delete
    
    var title: String {
        switch self {
        case .update: return "Select Item to Update"
        case .delete: return "Select Item to Delete"
        }
    }
}

enum ContentType {
    case news
    case announcements
    case events
    
    var listTitle: String {
        switch self {
        case .news: return "News List"
        case .announcements: return "Announcements"
        case .events: return "Events"
        }
    }
    
    var searchPlaceholder: String {
        switch self {
        case .news: return "news"
        case .announcements: return "announcements"
        case .events: return "events"
        }
    }
}
