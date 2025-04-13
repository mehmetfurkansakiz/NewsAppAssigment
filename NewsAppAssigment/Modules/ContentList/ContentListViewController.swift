//
//  ContentListViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import UIKit

class ContentListViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContentListSearchCell.self, forCellReuseIdentifier: ContentListSearchCell.identifier)
        tableView.register(ContentListTableViewCell.self, forCellReuseIdentifier: ContentListTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    var viewModel: ContentListViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.fetchNews()
    }
}

// MARK: - ViewModelDelegate
extension ContentListViewController: ContentListViewModelDelegate {
    func handleContentListViewModelOutput(_ output: ContentListViewModelOutput) {
        switch output {
        case .showLoading:
            showLoadingIndicator()
        case .hideLoading:
            hideLoadingIndicator()
        case .showError(let message):
            showError(message: message)
        case .reloadData:
            contentTableView.reloadData()
        case .reloadNewsSection:
            if let newsSectionIndex = viewModel.sections.firstIndex(of: .news) {
                let indexSet = IndexSet(integer: newsSectionIndex)
                contentTableView.reloadSections(indexSet, with: .automatic)
            }
        case .deleteSuccess(let message):
            showSuccess(message: message)
        case .showDeleteConfirmation(let news):
            showDeleteConfirmation(for: news)
        }
    }
    
    func navigate(to route: ContentListRouter) {
        switch route {
        case .updateNews(let viewModel):
            navigationController?.pushViewController(UpdateNewsBuilder.make(with: viewModel), animated: true)
        }
    }
}

// MARK: - Private Methods
private extension ContentListViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        title = viewModel.mode.title
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(contentTableView)
    }
    
    func configureLayout() {
        contentTableView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor, paddingLeading: 16,
            trailing: view.trailingAnchor, paddingTrailing: 16
        )
    }
}

// MARK: - Actions
private extension ContentListViewController {
    
    private func showDeleteConfirmation(for news: News) {
        let alert = UIAlertController(
            title: "Delete News",
            message: "Are you sure you want to delete this news?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.viewModel.confirmDelete(news)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ContentListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .search:
            return 1
        case .news:
            return viewModel.filteredNews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .search:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentListSearchCell.identifier, for: indexPath) as? ContentListSearchCell else {
                return UITableViewCell()
            }
            
            cell.searchHandler = { [weak self] searchText in
                self?.viewModel.filterNews(with: searchText)
            }
            
            return cell
            
        case .news:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentListTableViewCell.identifier, for: indexPath) as? ContentListTableViewCell else {
                return UITableViewCell()
            }
            
            let news = viewModel.filteredNews[indexPath.row]
            cell.configure(with: news, mode: viewModel.mode)
            cell.actionHandler = { [weak self] news in
                if self?.viewModel.mode == .update {
                    self?.viewModel.selectNews(news)
                } else {
                    self?.viewModel.deleteNews(news)
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        guard section == .news else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = viewModel.filteredNews[indexPath.row]
        viewModel.selectNews(selectedNews)
    }
}
