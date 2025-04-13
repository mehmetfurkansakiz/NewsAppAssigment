//
//  SettingsTableViewCell.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 19.03.2025.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SettingsTableViewCell"
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "303030")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "303030")
        return label
    }()
    
    private lazy var customDisclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "303030")
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        customSelectionStyle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with setting: Settings) {
        titleLabel.text = setting.title
        iconImageView.image = UIImage(systemName: setting.iconName)
    }
}

// MARK: - Private Methods
private extension SettingsTableViewCell {
    func configureView() {        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "EEEEEE")
        self.backgroundView = backgroundView
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(customDisclosureIndicator)
    }
    
    func configureLayout() {
        iconImageView.setupAnchors(
            leading: contentView.leadingAnchor, paddingLeading: 16,
            centerY: contentView.centerYAnchor,
            width: 24,
            height: 24
        )
        
        titleLabel.setupAnchors(
            leading: iconImageView.trailingAnchor, paddingLeading: 16,
            centerY: contentView.centerYAnchor
        )
        
        customDisclosureIndicator.setupAnchors(
            leading: titleLabel.trailingAnchor, paddingLeading: 8,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            centerY: contentView.centerYAnchor,
            height: 16
        )
    }
    
    private func customSelectionStyle() {
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor(named: "A9A9A9")?.withAlphaComponent(0.1)
        self.selectedBackgroundView = selectionView
    }
}
