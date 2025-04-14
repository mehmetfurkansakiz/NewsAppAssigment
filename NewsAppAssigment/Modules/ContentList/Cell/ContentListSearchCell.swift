//
//  ContentListSearchCell.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 11.04.2025.
//

import UIKit

final class ContentListSearchCell: UITableViewCell, UITextFieldDelegate {
    static let identifier = "ContentListSearchCell"
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(named: "EEEEEE")
        textField.textColor = UIColor(named: "303030")
        textField.layer.cornerRadius = 8
        textField.clearButtonMode = .whileEditing
        textField.isUserInteractionEnabled = true
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "A9A9A9")!,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: placeholderAttributes
        )
        
        if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(
                UIImage(systemName: "xmark.circle.fill")?
                    .withTintColor(UIColor(named: "A9A9A9")!, renderingMode: .alwaysOriginal),
                for: .normal
            )
        }
        
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = UIColor(named: "303030")
        searchImageView.contentMode = .center
        searchImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftPaddingView.addSubview(searchImageView)
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    var searchHandler: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        
        contentView.addSubview(searchTextField)
        searchTextField.setupAnchors(
            top: contentView.topAnchor, paddingTop: 8,
            bottom: contentView.bottomAnchor, paddingBottom: 8,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            height: 48
        )
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        searchHandler?(textField.text ?? "")
    }
}
