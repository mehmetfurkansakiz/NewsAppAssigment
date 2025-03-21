//
//  HomeViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 13.03.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var viewModel: HomeViewModelProtocol! {
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
extension HomeViewController: HomeViewModelDelegate {
    func handleHomeViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .reloadTableView:
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
}

// MARK: - Private Methods
private extension HomeViewController {
    func configureView() {
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(newsTableView)
    }
    
    func configureLayout() {
        newsTableView.setupAnchors(
            top: view.topAnchor, paddingTop: 8,
            bottom: view.bottomAnchor, paddingBottom: 8,
            leading: view.leadingAnchor, paddingLeading: 16,
            trailing: view.trailingAnchor, paddingTrailing: 16
        )
    }
}

// MARK: - TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.news[indexPath.row].title
        return cell
    }
}
