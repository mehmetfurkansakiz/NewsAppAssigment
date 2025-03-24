//
//  SignInViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NewsApp"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = UIColor(named: "6C63FF")
        label.textAlignment = .center
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "male-avatar-icon")
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "181818")
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.layer.masksToBounds = true
        textField.setLeftPadding(8)
        textField.setRightPadding(8)
        let placeholderText = "Enter your email"
        let placeholderColor = UIColor(named: "303030")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!]
        )
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.layer.masksToBounds = true
        let placeholderText = "Enter your password"
        let placeholderColor = UIColor(named: "303030")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!]
        )
        return textField
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = UIColor(named: "6C63FF")!
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "6C63FF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(named: "181818")
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create an Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = UIColor(named: "6C63FF")!
        return button
    }()
    
    var viewModel: SignInViewModelProtocol! {
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
extension SignInViewController: SignInViewModelDelegate {
    func handleSignInViewModelOutput(_ output: SignInViewModelOutput) {
        switch output {
            
        }
    }
}

// MARK: - Private Methods
extension SignInViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(avatarImageView)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(orLabel)
        view.addSubview(createAccountButton)
    }
    
    func configureLayout() {
        titleLabel.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20,
            centerX: view.centerXAnchor
        )
        
        avatarImageView.setupAnchors(
            top: titleLabel.bottomAnchor, paddingTop: 20,
            centerX: view.centerXAnchor,
            dynamicWidth: view.widthAnchor, aspectRatio: 3, priority: .defaultHigh
        )
        
        signInLabel.setupAnchors(
            top: avatarImageView.bottomAnchor, paddingTop: 20,
            centerX: view.centerXAnchor
        )
        
        emailLabel.setupAnchors(
            top: signInLabel.bottomAnchor, paddingTop: 20,
            leading: view.leadingAnchor, paddingLeading: 20
        )
        
        emailTextField.setupAnchors(
            top: emailLabel.bottomAnchor, paddingTop: 8,
            leading: view.leadingAnchor, paddingLeading: 20,
            trailing: view.trailingAnchor, paddingTrailing: 20,
            height: 48
        )
        
        passwordLabel.setupAnchors(
            top: emailTextField.bottomAnchor, paddingTop: 20,
            leading: view.leadingAnchor, paddingLeading: 20
        )
        
        passwordTextField.setupAnchors(
            top: passwordLabel.bottomAnchor, paddingTop: 8,
            leading: view.leadingAnchor, paddingLeading: 20,
            trailing: view.trailingAnchor, paddingTrailing: 20,
            height: 48
        )
        
        forgotPasswordButton.setupAnchors(
            top: passwordTextField.bottomAnchor, paddingTop: 8,
            trailing: view.trailingAnchor, paddingTrailing: 20
        )
        
        signInButton.setupAnchors(
            top: forgotPasswordButton.bottomAnchor, paddingTop: 20,
            leading: view.leadingAnchor, paddingLeading: 20,
            trailing: view.trailingAnchor, paddingTrailing: 20,
            height: 50
        )
        
        orLabel.setupAnchors(
            top: signInButton.bottomAnchor, paddingTop: 4,
            centerX: view.centerXAnchor
        )
        
        createAccountButton.setupAnchors(
            top: orLabel.bottomAnchor,
            centerX: view.centerXAnchor
        )
    }
}

#Preview {
    SignInViewController()
}
