//
//  HomeDetailViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 31.03.2025.
//

import UIKit
import Kingfisher

class HomeDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "181818")
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "A9A9A9")
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let articleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "303030")
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "A9A9A9")
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    var viewModel: HomeDetailViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.loadNewsDetail()
    }
}

// MARK: - ViewModelDelegate
extension HomeDetailViewController: HomeDetailViewModelDelegate {
    func handleHomeDetailViewModelOutput(_ output: HomeDetailViewModelOutput) {
        switch output {
        case .showNewsDetail(let selectedNews):
            configureNewsDetail(with: selectedNews)
        }
    }
}

// MARK: - Private Methods
private extension HomeDetailViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        navigationItem.title = "News Detail"
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(articleLabel)
        contentView.addSubview(authorLabel)
    }
    
    func configureLayout() {
        scrollView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
        
        contentView.setupAnchors(
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            width: UIScreen.main.bounds.width
        )
        
        titleLabel.setupAnchors(
            top: contentView.topAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16
        )
        
        dateLabel.setupAnchors(
            top: titleLabel.bottomAnchor, paddingTop: 8,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16
        )
        
        imageView.setupAnchors(
            top: dateLabel.bottomAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 200
        )
        
        articleLabel.setupAnchors(
            top: imageView.bottomAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16
        )
        
        authorLabel.setupAnchors(
            top: articleLabel.bottomAnchor, paddingTop: 16,
            bottom: contentView.bottomAnchor, paddingBottom: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16
            
        )
    }
    
    private func configureNewsDetail(with news: News) {
        titleLabel.text = news.title
        articleLabel.text = news.article
        authorLabel.text = news.author
        
        if let createdAt = news.createdAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateLabel.text = dateFormatter.string(from: createdAt)
        }
        
        if let imageUrl = news.imageUrl, let url = URL(string: imageUrl) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder-image"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ])
        }
    }
}
