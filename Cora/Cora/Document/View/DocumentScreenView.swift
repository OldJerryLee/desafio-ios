//
//  DocumentScreenView.swift
//  Cora
//
//  Created by Fabricio Pujol on 01/09/24.
//

import UIKit

protocol DocumentScreenDelegate: AnyObject {
    func nextButton()
}

final class DocumentScreenView: UIView {
    
    lazy var documentTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 16)
        label.text = "Bem-vindo de volta!"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var documentSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 22)
        label.text = "Qual seu CPF?"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var documentTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .none
        tf.keyboardType = .numberPad
        tf.textColor = .coraDarkerGrayText
        tf.font = UIFont(name: CustomFont.avenir, size: 22)
        tf.tintColor = .coraDarkerGrayText
        return tf
    }()
    
    lazy var loginIntroButtonLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirBold, size: 14)
        label.text = "Próximo"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var loginIntroButtonImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "rightVector")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .coraWhite
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var loginIntroButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginIntroButtonLabel, UIView(),loginIntroButtonImage])
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
    
    private weak var delegate: DocumentScreenDelegate?
    private var loginButtonBottomConstraint: NSLayoutConstraint?
    
    func delegate(delegate: DocumentScreenDelegate?) {
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
        self.addSubview(self.documentTitleLabel)
        self.addSubview(self.documentSubtitleLabel)
        self.addSubview(self.documentTextField)
        self.addSubview(self.loginIntroButtonStack)
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.documentTextField.delegate = delegate
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.documentTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.documentTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.documentTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.documentSubtitleLabel.topAnchor.constraint(equalTo: self.documentTitleLabel.bottomAnchor, constant: 16),
            self.documentSubtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.documentSubtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.documentTextField.topAnchor.constraint(equalTo: self.documentSubtitleLabel.bottomAnchor, constant: 32),
            self.documentTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.documentTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.documentTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.loginIntroButtonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.loginIntroButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.loginIntroButtonStack.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        self.loginButtonBottomConstraint = self.loginIntroButtonStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        self.loginButtonBottomConstraint?.isActive = true
    }
    
    func enableButton() {
        loginIntroButtonStack.isUserInteractionEnabled = true
        loginIntroButtonStack.backgroundColor = .coraPink
    }
    
    func disableButton() {
        loginIntroButtonStack.isUserInteractionEnabled = false
        loginIntroButtonStack.backgroundColor = .coraDisableButtonGray
    }
    
    // MARK: - Keyboard Handling
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            loginButtonBottomConstraint?.constant = -keyboardHeight// - 16
            
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
