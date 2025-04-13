//
//  UpdateNewsViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 9.04.2025.
//

import UIKit
import Kingfisher

class UpdateNewsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "A9A9A9")?.withAlphaComponent(0.1)
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var imageContainerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
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
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var categoryTextField: UITextField = {
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
    
    private lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.text = "Article"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var articleTextView: UITextView = {
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
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update News", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "6C63FF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private var selectedImageData: Data?
    
    var viewModel: UpdateNewsViewModelProtocol! {
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
extension UpdateNewsViewController: UpdateNewsViewModelDelegate {
    func handleUpdateNewsViewModelOutput(_ output: UpdateNewsViewModelOutput) {
        switch output {
        case .showLoading:
            showLoadingIndicator()
        case .hideLoading:
            hideLoadingIndicator()
        case .showError(let message):
            showError(message: message)
        case .showNewsUpdate(let selectedNews):
            configureUpdateNews(with: selectedNews)
        case .updateSuccess:
            showSuccess(message: "News updated successfully") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK: - Private Methods
private extension UpdateNewsViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        title = "Update News"
        
        addViews()
        configureLayout()
        setupActions()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        imageView.addSubview(imageContainerButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryTextField)
        contentView.addSubview(articleLabel)
        contentView.addSubview(articleTextView)
        contentView.addSubview(updateButton)
    }
    
    func configureLayout() {
        scrollView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
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
        
        updateButton.setupAnchors(
            top: articleTextView.bottomAnchor, paddingTop: 16,
            bottom: contentView.bottomAnchor, paddingBottom: 16,
            leading: contentView.leadingAnchor, paddingLeading: 16,
            trailing: contentView.trailingAnchor, paddingTrailing: 16,
            height: 48
        )
    }
    
    private func configureUpdateNews(with news: News) {
        titleTextField.text = news.title
        articleTextView.text = news.article
        categoryTextField.text = news.category
        
        if let imageUrlString = news.imageUrl,
           let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
        }
    }
}

// MARK: - Actions
extension UpdateNewsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func setupActions() {
        imageContainerButton.addTarget(self, action: #selector(imageViewTapped), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            selectedImageData = selectedImage.jpegData(compressionQuality: 0.5)
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
    
    @objc func updateButtonTapped() {
        let imageData: Data? = selectedImageData
        
        let updatedNews = News(
            id: viewModel.selectedNews.id,
            title: titleTextField.text,
            article: articleTextView.text,
            category: categoryTextField.text,
            createdAt: viewModel.selectedNews.createdAt,
            author: viewModel.selectedNews.author,
            imageUrl: viewModel.selectedNews.imageUrl,
            imageData: imageData
        )
        
        viewModel.updateNews(news: updatedNews)
    }
}
