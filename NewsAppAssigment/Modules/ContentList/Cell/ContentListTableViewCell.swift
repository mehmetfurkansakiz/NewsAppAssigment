//
//  ContentListTableViewCell.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import UIKit

class ContentListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "ContentListCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "EEEEEE")
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor(named: "181818")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "181818")
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "303030")
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "6C63FF")
        return button
    }()
    
    private lazy var containerTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(containerTapped))
        return gesture
    }()
    
    private var mode: ListMode = .update
    private var news: News?
    var actionHandler: ((News) -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News, mode: ListMode = .update) {
        self.news = news
        self.mode = mode
        
        titleLabel.text = news.title
        subtitleLabel.text = news.category
        dateLabel.text = news.createdAt?.formatted(date: .abbreviated, time: .shortened)
        
        let buttonImage = mode == .update ? UIImage(systemName: "chevron.right") : UIImage(systemName: "xmark")
        actionButton.setImage(buttonImage, for: .normal)
        actionButton.tintColor = mode == .update ? .systemBlue : .systemRed
    }
}

// MARK: - Private Methods
private extension ContentListTableViewCell {
    func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addViews()
        configureLayout()
        setupActions()
    }
    
    func addViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(actionButton)
    }
    
    func configureLayout() {
        containerView.setupAnchors(
            top: contentView.topAnchor, paddingTop: 8,
            bottom: contentView.bottomAnchor, paddingBottom: 8,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor
        )
        
        titleLabel.setupAnchors(
            top: containerView.topAnchor, paddingTop: 12,
            leading: containerView.leadingAnchor, paddingLeading: 16,
            trailing: actionButton.leadingAnchor, paddingTrailing: 8
        )
        
        subtitleLabel.setupAnchors(
            top: titleLabel.bottomAnchor, paddingTop: 4,
            leading: containerView.leadingAnchor, paddingLeading: 16,
            trailing: actionButton.leadingAnchor, paddingTrailing: 8
        )
        
        dateLabel.setupAnchors(
            top: subtitleLabel.bottomAnchor, paddingTop: 4,
            bottom: containerView.bottomAnchor, paddingBottom: 12,
            leading: containerView.leadingAnchor, paddingLeading: 16
        )
        
        actionButton.setupAnchors(
            trailing: containerView.trailingAnchor, paddingTrailing: 16,
            centerY: containerView.centerYAnchor,
            width: 24,
            height: 24
        )
    }
}

// MARK: - Actions
private extension ContentListTableViewCell {
    func setupActions() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        containerView.addGestureRecognizer(containerTapGesture)
    }
    
    @objc func actionButtonTapped() {
        containerTapped()
    }
    
    @objc func containerTapped() {
        guard let news = news else { return }
        actionHandler?(news)
    }
}
