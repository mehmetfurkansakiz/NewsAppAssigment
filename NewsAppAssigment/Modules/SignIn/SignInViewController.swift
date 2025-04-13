//
//  SignInViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 21.03.2025.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NewsApp"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = UIColor(named: "6C63FF")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "male-avatar-icon")
        return imageView
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "181818")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.layer.masksToBounds = true
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
        textField.setPadding(left: 8, right: 8)
        let placeholderText = "Enter your email"
        let placeholderColor = UIColor(named: "303030")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!]
        )
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.layer.masksToBounds = true
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
        let placeholderText = "Enter your password"
        let placeholderColor = UIColor(named: "303030")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!]
        )
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = UIColor(named: "6C63FF")!
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "6C63FF")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = UIColor(named: "181818")
        return label
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create an Account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = UIColor(named: "6C63FF")!
        return button
    }()
    
    var viewModel: SignInViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupDismissKeyboardGesture()
    }
}

// MARK: - ViewModelDelegate

extension SignInViewController: SignInViewModelDelegate {
    func handleSignInViewModelOutput(_ output: SignInViewModelOutput) {
        switch output {
        case .showLoading:
            showLoadingIndicator()
        case .hideLoading:
            hideLoadingIndicator()
        case .showError(message: let message):
            showError(message: message)
        case .signInSuccess:
            navigateToWithAnimation(to: TabBarController())
        }
    }
}

// MARK: - Private Methods

extension SignInViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        
        addViews()
        configureLayout()
        setupActions()
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
            top: emailTextField.bottomAnchor, paddingTop: 16,
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

// MARK: - Actions

private extension SignInViewController {
    func setupActions() {
        // Configure sign-in button action
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc func forgotPasswordButtonTapped() {
        // TODO: Implement forgot password functionality
        print("Forgot Password tapped")
    }
    
    @objc func signInButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else {
            return
        }
        
        viewModel.signIn(email: email, password: password)
    }
    
    @objc func createAccountButtonTapped() {
        navigateToWithAnimation(to: SignUpBuilder.make(with: SignUpViewModel()))
    }
    
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

#Preview {
    SignInViewController()
}
