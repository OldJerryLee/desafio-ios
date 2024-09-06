//
//  PasswordScreenView.swift
//  Cora
//
//  Created by Fabricio Pujol on 05/09/24.
//

import UIKit

protocol PasswordScreenDelegate: AnyObject {
    func nextButton()
    func forgotPasswordButton()
}

final class PasswordScreenView: UIView {
    
    lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 22)
        label.text = "Digite sua senha de acesso"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var securityPasswordButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(self.changeSecurityPassword), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.tintColor = .coraPink
        return button
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.keyboardType = .default
        tf.textColor = .coraDarkerGrayText
        tf.font = UIFont(name: CustomFont.avenir, size: 22)
        tf.tintColor = .coraDarkerGrayText
        tf.isSecureTextEntry = true
        tf.rightView = securityPasswordButton
        tf.rightViewMode = .always
        return tf
    }()
    
    lazy var passwordNextButtonLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirBold, size: 14)
        label.text = "Próximo"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var passwordNextButtonImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "rightVector")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .coraWhite
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var passwordNextButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordNextButtonLabel, UIView(),passwordNextButtonImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .coraPink
        stack.layer.cornerRadius = 12
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedLoginButton))
        stack.addGestureRecognizer(tapGesture)
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy var forgotPasswordButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueci minha senha", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenirBold, size: 14)
        button.setTitleColor(.coraPink, for: .normal)
        button.addTarget(self, action: #selector(self.tappedForgotPasswordButton), for: .touchUpInside)
        return button
    }()
    
    private weak var delegate: PasswordScreenDelegate?
    private var loginButtonBottomConstraint: NSLayoutConstraint?
    private var isPasswordHidden: Bool = true
    
    func delegate(delegate: PasswordScreenDelegate?) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpConstraints()
        self.registerForKeyboardNotifications()
        self.disableButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackGround() {
        self.backgroundColor = .coraWhite
    }
    
    private func configSuperView() {
        self.addSubview(self.passwordTitleLabel)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.passwordNextButtonStack)
        self.addSubview(self.forgotPasswordButton)
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.passwordTextField.delegate = delegate
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.passwordTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.passwordTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.passwordTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.passwordTitleLabel.bottomAnchor, constant: 32),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.forgotPasswordButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 48),
            self.forgotPasswordButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            self.passwordNextButtonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.passwordNextButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.passwordNextButtonStack.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.loginButtonBottomConstraint = self.passwordNextButtonStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        self.loginButtonBottomConstraint?.isActive = true
    }
    
    func enableButton() {
        passwordNextButtonStack.isUserInteractionEnabled = true
        passwordNextButtonStack.backgroundColor = .coraPink
    }
    
    func disableButton() {
        passwordNextButtonStack.isUserInteractionEnabled = false
        passwordNextButtonStack.backgroundColor = .coraDisableButtonGray
    }
    
    // MARK: - Keyboard Handling
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            loginButtonBottomConstraint?.constant = -keyboardHeight
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        loginButtonBottomConstraint?.constant = -16
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func tappedLoginButton() {
        self.delegate?.nextButton()
    }
    
    @objc private func tappedForgotPasswordButton() {
        self.delegate?.forgotPasswordButton()
    }
    
    @objc private func changeSecurityPassword() {
        isPasswordHidden.toggle()
        
        if isPasswordHidden {
            securityPasswordButton.setImage(UIImage(systemName: "eye.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
            passwordTextField.isSecureTextEntry = true
        } else {
            securityPasswordButton.setImage(UIImage(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
