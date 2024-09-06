//
//  IntroScreenView.swift
//  Cora
//
//  Created by Fabricio Pujol on 31/08/24.
//

import UIKit

protocol LoginScreenDelegate:AnyObject{
    func signupIntroButton()
    func loginIntroButton()
}

final class IntroScreenView: UIView {
    
    private weak var delegate:LoginScreenDelegate?
    
    func delegate(delegate:LoginScreenDelegate?){
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var introAppImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "introImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var introAppLogoImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "introLogo")
        image.tintColor = .green
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var introTitleBoldLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirBold, size: 28)
        label.text = "Conta Digital PJ"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var introTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirRegular, size: 28)
        label.text = "Poderosamente simples"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var introSubtitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirRegular, size: 16)
        label.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        label.numberOfLines = 3
        return label
    }()
    
    lazy var registerButtonLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraPink
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Quero fazer parte!"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var registerButtonImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "rightVector")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var registerIntroButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registerButtonLabel, UIView(),registerButtonImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .coraWhite
        stack.layer.cornerRadius = 16
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedRegisterButton))
        stack.addGestureRecognizer(tapGesture)
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy var loginIntroButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Já sou cliente", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenirBold, size: 14)
        button.setTitleColor(.coraWhite, for: .normal)
        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    private func configBackGround(){
        self.backgroundColor = .coraPink
    }
        
    private func configSuperView(){
        self.addSubview(self.introAppImageView)
        self.addSubview(self.introAppLogoImageView)
        self.addSubview(self.introTitleBoldLabel)
        self.addSubview(self.introTitleLabel)
        self.addSubview(self.introSubtitleLabel)
        self.addSubview(self.registerIntroButtonStack)
        self.addSubview(self.loginIntroButton)
    }
    
    @objc private func tappedLoginButton(){
        self.delegate?.loginIntroButton()
    }
    
    @objc private func tappedRegisterButton(){
        self.delegate?.signupIntroButton()
    }
    
    private func setUpContraints(){
        NSLayoutConstraint.activate([
            self.introAppImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.introAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.introAppImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.introAppImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4934),
            
            self.introAppLogoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.introAppLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.introAppLogoImageView.heightAnchor.constraint(equalToConstant: 24),
            self.introAppLogoImageView.widthAnchor.constraint(equalToConstant: 90),
            
            self.introTitleBoldLabel.topAnchor.constraint(equalTo: self.introAppImageView.bottomAnchor, constant: 16),
            self.introTitleBoldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.introTitleBoldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.introTitleLabel.topAnchor.constraint(equalTo: self.introTitleBoldLabel.bottomAnchor),
            self.introTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.introTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.introSubtitleLabel.topAnchor.constraint(equalTo: self.introTitleLabel.bottomAnchor, constant: 16),
            self.introSubtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.introSubtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.loginIntroButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            self.loginIntroButton.heightAnchor.constraint(equalToConstant: 20),
            self.loginIntroButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.registerIntroButtonStack.bottomAnchor.constraint(equalTo: self.loginIntroButton.topAnchor, constant: -30),
            self.registerIntroButtonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.registerIntroButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.registerIntroButtonStack.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}
