//
//  AdminNewsCollectionViewCell.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 4.04.2025.
//

import UIKit

class AdminNewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "AdminNewsCollectionViewCell"
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "FBFBFB")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "FBFBFB")
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, icon: String, color: UIColor) {
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: icon)
        contentView.backgroundColor = color
    }
}

// MARK: - Private Methods
private extension AdminNewsCollectionViewCell {
    func configureView() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func configureLayout() {
        stackView.setupAnchors(
            top: contentView.topAnchor, paddingTop: 24,
            bottom: contentView.bottomAnchor, paddingBottom: 24,
            leading: contentView.leadingAnchor, paddingLeading: 8,
            trailing: contentView.trailingAnchor, paddingTrailing: 8,
            centerY: contentView.centerYAnchor
        )
        
        iconImageView.setupAnchors(
            width: 32,
            height: 32
        )
    }
}
