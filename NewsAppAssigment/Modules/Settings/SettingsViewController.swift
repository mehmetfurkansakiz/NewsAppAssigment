//
//  SettingsViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 13.03.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "FBFBFB")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var viewModel: SettingsViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - ViewModelDelegate
extension SettingsViewController: SettingsViewModelDelegate {
    func handleSettingsViewModelOutput(_ output: SettingsViewModelOutput) {
        switch output {
        case .updateTableView:
            settingsTableView.reloadData()
        case .showAdminPanel:
            print("Navigate to admin panel")
        case .showNotificationSettings:
            print("Navigate to notification settings")
        case .rateApp:
            print("Open App Store rating")
        case .showPrivacyPolicy:
            print("Show privacy policy")
        case .showTermsOfService:
            print("Show terms of service")
        }
    }
}

// MARK: - Private Methods
private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        
        if let navigationBar = navigationController?.navigationBar {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "181818")!]
            navigationBar.titleTextAttributes = textAttributes
            navigationBar.largeTitleTextAttributes = textAttributes
        }
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(settingsTableView)
    }
    
    func configureLayout() {
        settingsTableView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor
        )
    }
}

// MARK: - TableView
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SettingsSection(rawValue: section)!
        return sectionType.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let sectionType = SettingsSection(rawValue: indexPath.section)!
        let setting = sectionType.settings[indexPath.row]
        cell.configure(with: setting)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor(named: "A9A9A9")!
        titleLabel.text = SettingsSection(rawValue: section)?.title
        
        headerView.addSubview(titleLabel)
        
        titleLabel.setupAnchors(
            top: headerView.topAnchor, paddingTop: 8,
            bottom: headerView.bottomAnchor, paddingBottom: 8,
            leading: headerView.leadingAnchor, paddingLeading: 16,
            trailing: headerView.trailingAnchor, paddingTrailing: 16
        )
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionType = SettingsSection(rawValue: indexPath.section)!
        let setting = sectionType.settings[indexPath.row]
        viewModel.didSelectSetting(at: setting.rawValue)
    }
}
