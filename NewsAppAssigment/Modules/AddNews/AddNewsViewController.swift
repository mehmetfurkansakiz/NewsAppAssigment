//
//  AddNewsViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 5.04.2025.
//

import UIKit

class AddNewsViewController: UIViewController {
    
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "A9A9A9")?.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let imageContainerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "6C63FF")
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
        textField.setPadding(left: 8, right: 8)
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
        textField.setPadding(left: 8, right: 8)
        return textField
    }()
    
    private let articleLabel: UILabel = {
        let label = UILabel()
        label.text = "Article"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let articleTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = UIColor(named: "303030")
        textView.setPadding(UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8))
        return textView
    }()
    
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create News", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "6C63FF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    var viewModel: AddNewsViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupActions()
    }
}

// MARK: - ViewModelDelegate
extension AddNewsViewController: AddNewsViewModelDelegate {
    func handleAddNewsViewModelOutput(_ output: AddNewsViewModelOutput) {
        switch output {
        case .showLoading:
            showLoadingIndicator()
        case .hideLoading:
            hideLoadingIndicator()
        case .showError(let message):
            showError(message: message)
        case .newsCreated:
            let alert = UIAlertController(title: "Success", message: "News created successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            present(alert, animated: true)
        }
    }
}

// MARK: - Private Methods
private extension AddNewsViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        navigationItem.title = "Create News"
        
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        imageView.addSubview(imageContainerButton)
        contentView.addSubview(addImageButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryTextField)
        contentView.addSubview(articleLabel)
        contentView.addSubview(articleTextView)
        contentView.addSubview(createButton)
    }
    
    func configureLayout() {
        scrollView.setupAnchors(
            top: view.topAnchor,
            bottom: view.bottomAnchor,
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
        
        imageView.setupAnchors(
            top: contentView.topAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 240
        )
        
        imageContainerButton.setupAnchors(
            top: imageView.topAnchor,
            bottom: imageView.bottomAnchor,
            leading: imageView.leadingAnchor,
            trailing: imageView.trailingAnchor
        )
        
        addImageButton.setupAnchors(
            centerX: imageView.centerXAnchor,
            centerY: imageView.centerYAnchor,
            width: 64,
            height: 64
        )
        
        titleLabel.setupAnchors(
            top: imageView.bottomAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16
        )
        
        titleTextField.setupAnchors(
            top: titleLabel.bottomAnchor, paddingTop: 8,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 48
        )
        
        categoryLabel.setupAnchors(
            top: titleTextField.bottomAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16
        )
        
        categoryTextField.setupAnchors(
            top: categoryLabel.bottomAnchor, paddingTop: 8,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 48
        )
        
        articleLabel.setupAnchors(
            top: categoryTextField.bottomAnchor, paddingTop: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16
        )
        
        articleTextView.setupAnchors(
            top: articleLabel.bottomAnchor, paddingTop: 8,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 240
        )
        
        createButton.setupAnchors(
            top: articleTextView.bottomAnchor, paddingTop: 16,
            bottom: contentView.bottomAnchor, paddingBottom: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 50
        )
    }
}

// MARK: - Actions
extension AddNewsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func setupActions() {
        imageContainerButton.addTarget(self, action: #selector(imageViewTapped), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            addImageButton.isHidden = true
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    @objc func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    @objc func createButtonTapped() {
        guard let image = imageView.image,
              let imageData = image.jpegData(compressionQuality: 0.5) else {
            showError(message: "Please select an image")
            return
        }
        
        let news = News(
            title: titleTextField.text,
            article: articleTextView.text,
            category: categoryTextField.text,
            createdAt: nil,
            author: nil,
            imageUrl: nil,
            imageData: imageData
        )
        
        viewModel.createNews(news: news)
    }
}

#Preview {
    AddNewsBuilder.make(with: AddNewsViewModel())
}
