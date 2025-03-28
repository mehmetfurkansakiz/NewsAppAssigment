//
//  SignUpViewController.swift
//  NewsAppAssigment
//
//  Created by furkan sakız on 23.03.2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
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
        imageView.image = UIImage(named: "female-avatar-icon")
        return imageView
    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
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
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
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
    
    private let passwordRepeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Repeat Password"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "A9A9A9")
        return label
    }()
    
    private let passwordRepeatTextField: UITextField = {
        let textField = PasswordTextField()
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "A9A9A9")?.cgColor
        textField.layer.masksToBounds = true
        textField.backgroundColor = .clear
        textField.textColor = UIColor(named: "303030")
        let placeholderText = "Repeat your password"
        let placeholderColor = UIColor(named: "303030")
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!]
        )
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
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
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an account ? Sign In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = UIColor(named: "6C63FF")!
        return button
    }()
    
    var viewModel: SignUpViewModelProtocol! {
        didSet {
            self.viewModel.delegate = self
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
extension SignUpViewController: SignUpViewModelDelegate {
    func handleSignUpViewModelOutput(_ output: SignUpViewModelOutput) {
        switch output {
        case .showLoading:
            showLoadingIndicator()
        case .hideLoading:
            hideLoadingIndicator()
        case .showError(message: let message):
            showError(message: message)
        case .signUpSuccess:
            navigateToWithAnimation(to: TabBarController())
        }
    }
}

// MARK: - Private Methods
private extension SignUpViewController {
    func configureView() {
        view.backgroundColor = UIColor(named: "FBFBFB")
        
        addViews()
        configureLayout()
        setupActions()
    }
    
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(avatarImageView)
        view.addSubview(signUpLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordRepeatLabel)
        view.addSubview(passwordRepeatTextField)
        view.addSubview(signUpButton)
        view.addSubview(orLabel)
        view.addSubview(signInButton)
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
        
        signUpLabel.setupAnchors(
            top: avatarImageView.bottomAnchor, paddingTop: 20,
            centerX: view.centerXAnchor
        )
        
        emailLabel.setupAnchors(
            top: signUpLabel.bottomAnchor, paddingTop: 20,
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
        
        passwordRepeatLabel.setupAnchors(
            top: passwordTextField.bottomAnchor, paddingTop: 16,
            leading: view.leadingAnchor, paddingLeading: 20
        )
        
        passwordRepeatTextField.setupAnchors(
            top: passwordRepeatLabel.bottomAnchor, paddingTop: 8,
            leading: view.leadingAnchor, paddingLeading: 20,
            trailing: view.trailingAnchor, paddingTrailing: 20,
            height: 48
        )
        
        signUpButton.setupAnchors(
            top: passwordRepeatTextField.bottomAnchor, paddingTop: 32,
            leading: view.leadingAnchor, paddingLeading: 20,
            trailing: view.trailingAnchor, paddingTrailing: 20,
            height: 50
        )
        
        orLabel.setupAnchors(
            top: signUpButton.bottomAnchor, paddingTop: 4,
            centerX: view.centerXAnchor
        )
        
        signInButton.setupAnchors(
            top: orLabel.bottomAnchor,
            centerX: view.centerXAnchor
        )
    }
}

// MARK: - Actions
private extension SignUpViewController {
    func setupActions() {
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let passwordRepeat = passwordRepeatTextField.text else {
            return
        }
        
        viewModel.signUp(email: email, password: password, passwordRepeat: passwordRepeat)
    }
    
    @objc func signInButtonTapped() {
        navigateToWithAnimation(to: SignInBuilder.make(with: SignInViewModel()))
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
    SignUpViewController()
}
