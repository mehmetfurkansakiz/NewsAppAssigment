//
//  HomeTableViewCell.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 28.03.2025.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "HomeTableViewCell"
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "181818")
        label.numberOfLines = 2
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "303030")
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        newsImageView.image = nil
        authorLabel.text = nil
        categoryLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News) {
        titleLabel.text = news.title
        authorLabel.text = news.author
        if let category = news.category, let createdAt = news.createdAt {
            let timeAgo = Date().timeAgoSinceDate(createdAt)
            categoryLabel.text = "\(category) - \(timeAgo)"
        }
        
        if let imageUrl = news.imageUrl, let url = URL(string: imageUrl) {
            newsImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder-image"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ])
        }
    }
}

// MARK: - Private Methods
private extension HomeTableViewCell {
    func configureView() {
        contentView.backgroundColor = UIColor(named: "FBFBFB")
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(categoryLabel)
    }
    
    func configureLayout() {
        newsImageView.setupAnchors(
            top: contentView.topAnchor, paddingTop: 8,
            bottom: contentView.bottomAnchor, paddingBottom: 8,
            leading: contentView.leadingAnchor,
            width: 120,
            height: 120
        )
        
        titleLabel.setupAnchors(
            top: contentView.topAnchor, paddingTop: 8,
            leading: newsImageView.trailingAnchor, paddingLeading: 8,
            trailing: contentView.trailingAnchor, paddingTrailing: 8
        )
        
        authorLabel.setupAnchors(
            top: titleLabel.bottomAnchor, paddingTop: 8,
            leading: newsImageView.trailingAnchor, paddingLeading: 8
        )
        
        categoryLabel.setupAnchors(
            bottom: contentView.bottomAnchor, paddingBottom: 8,
            leading: newsImageView.trailingAnchor, paddingLeading: 8
        )
    }
}
