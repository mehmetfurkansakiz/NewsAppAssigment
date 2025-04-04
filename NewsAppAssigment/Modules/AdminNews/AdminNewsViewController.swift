//
//  AdminNewsViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 3.04.2025.
//

import UIKit

class AdminNewsViewController: UIViewController {
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AdminNewsCollectionViewCell.self, forCellWithReuseIdentifier: AdminNewsCollectionViewCell.identifier)
        return collectionView
    }()
    private let adminActions = AdminActions.allCases
    var viewModel: AdminNewsViewModelProtocol! {
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
extension AdminNewsViewController: AdminNewsViewModelDelegate {
    func handleAdminNewsViewModelOutput(_ output: AdminNewsViewModelOutput) {
        switch output {
            
        }
    }
}

// MARK: - Private Methods
private extension AdminNewsViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        navigationItem.title = "Admin Panel"
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor, paddingLeading: 16,
            trailing: view.trailingAnchor, paddingTrailing: 16
        )
    }
}

// MARK: - CollectionView
extension AdminNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adminActions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdminNewsCollectionViewCell.identifier, for: indexPath) as? AdminNewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let action = adminActions[indexPath.item]
        cell.configure(title: action.title, icon: action.icon, color: action.color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let totalSpacing = spacing * 2
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = availableWidth / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected action: \(adminActions[indexPath.item].title)")
    }
}

#Preview {
    AdminNewsBuilder.make(with: AdminNewsViewModel())
}
