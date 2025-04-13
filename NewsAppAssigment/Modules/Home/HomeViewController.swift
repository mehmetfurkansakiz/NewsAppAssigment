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
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func navigate(to route: HomeRoute) {
        switch route {
        case .homeDetail(let viewModel):
            let homeDetail = HomeDetailBuilder.make(with: viewModel)
            navigationController?.pushViewController(homeDetail, animated: true)
        }
    }
}

// MARK: - Private Methods
private extension HomeViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(newsTableView)
    }
    
    func configureLayout() {
        newsTableView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor, paddingLeading: 16,
            trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTrailing: 16
        )
    }
}

// MARK: - TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let news = viewModel.news[indexPath.row]
        cell.configure(with: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedNews = viewModel.news[indexPath.row]
        viewModel.select(with: selectedNews)
    }
}
