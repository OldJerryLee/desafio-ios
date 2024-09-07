//
//  StatementDetailsView.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import UIKit

protocol StatementDetailsViewDelegate:AnyObject{
    func shareDetailsButton()
}

final class StatementDetailsView: UIView {
    
    private weak var delegate:StatementDetailsViewDelegate?
    
    func delegate(delegate:StatementDetailsViewDelegate?){
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
    
    lazy var statementDetailImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_arrow-up-out")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var statementTitleBoldLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Transferência enviada"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementValueTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Valor"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementValueLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "R$ 154,00"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDateTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Data"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDateLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Hoje - 12/10/2019"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "De"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Dev iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromDocumentLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "CPF 123.456.789-10"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromBankLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Banco iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromAccountLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Agência 1234 - Conta 12345-6"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Para"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Chapter iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToDocumentLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "CPF 123.456.789-10"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToBankLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Banco Cora"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToAccountLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Agência 1234 - Conta 12345-6"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDescriptionTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Descrição"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDescriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies."
        label.numberOfLines = 3
        return label
    }()
    
    lazy var shareButtonLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Compartilhar comprovante"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var shareButtonImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_share-ios")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var shareIntroButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shareButtonLabel, UIView(),shareButtonImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .coraPink
        stack.layer.cornerRadius = 16
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedRegisterButton))
        stack.addGestureRecognizer(tapGesture)
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private func configBackGround(){
        self.backgroundColor = .coraWhite
    }
        
    private func configSuperView(){
        self.addSubview(self.statementDetailImage)
        self.addSubview(self.statementTitleBoldLabel)
        
        self.addSubview(self.statementValueTitleLabel)
        self.addSubview(self.statementValueLabel)
        
        self.addSubview(self.statementDateTitleLabel)
        self.addSubview(self.statementDateLabel)
        
        self.addSubview(self.statementFromTitleLabel)
        self.addSubview(self.statementFromLabel)
        self.addSubview(self.statementFromDocumentLabel)
        self.addSubview(self.statementFromBankLabel)
        self.addSubview(self.statementFromAccountLabel)
        
        self.addSubview(self.statementToTitleLabel)
        self.addSubview(self.statementToLabel)
        self.addSubview(self.statementToDocumentLabel)
        self.addSubview(self.statementToBankLabel)
        self.addSubview(self.statementToAccountLabel)
        
        self.addSubview(self.statementDescriptionTitleLabel)
        self.addSubview(self.statementDescriptionLabel)
        
        self.addSubview(self.shareIntroButtonStack)
    }
    
    @objc private func tappedRegisterButton(){
        self.delegate?.shareDetailsButton()
    }
    
    private func setUpContraints(){
        NSLayoutConstraint.activate([
            
            self.statementDetailImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            self.statementDetailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementDetailImage.heightAnchor.constraint(equalToConstant: 24),
            self.statementDetailImage.widthAnchor.constraint(equalToConstant: 24),
            
            self.statementTitleBoldLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            self.statementTitleBoldLabel.leadingAnchor.constraint(equalTo: self.statementDetailImage.trailingAnchor, constant: 8),
            self.statementTitleBoldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementValueTitleLabel.topAnchor.constraint(equalTo: self.statementTitleBoldLabel.bottomAnchor, constant: 24),
            self.statementValueTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementValueTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementValueLabel.topAnchor.constraint(equalTo: self.statementValueTitleLabel.bottomAnchor, constant: 4),
            self.statementValueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementDateTitleLabel.topAnchor.constraint(equalTo: self.statementValueLabel.bottomAnchor, constant: 24),
            self.statementDateTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementDateTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementDateLabel.topAnchor.constraint(equalTo: self.statementDateTitleLabel.bottomAnchor, constant: 4),
            self.statementDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementFromTitleLabel.topAnchor.constraint(equalTo: self.statementDateLabel.bottomAnchor, constant: 24),
            self.statementFromTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementFromTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementFromLabel.topAnchor.constraint(equalTo: self.statementFromTitleLabel.bottomAnchor, constant: 4),
            self.statementFromLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementFromLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementFromDocumentLabel.topAnchor.constraint(equalTo: self.statementFromLabel.bottomAnchor, constant: 4),
            self.statementFromDocumentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementFromDocumentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementFromBankLabel.topAnchor.constraint(equalTo: self.statementFromDocumentLabel.bottomAnchor),
            self.statementFromBankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementFromBankLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementFromAccountLabel.topAnchor.constraint(equalTo: self.statementFromBankLabel.bottomAnchor),
            self.statementFromAccountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementFromAccountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementToTitleLabel.topAnchor.constraint(equalTo: self.statementFromAccountLabel.bottomAnchor, constant: 24),
            self.statementToTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementToTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementToLabel.topAnchor.constraint(equalTo: self.statementToTitleLabel.bottomAnchor, constant: 4),
            self.statementToLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementToLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementToDocumentLabel.topAnchor.constraint(equalTo: self.statementToLabel.bottomAnchor, constant: 4),
            self.statementToDocumentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementToDocumentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementToBankLabel.topAnchor.constraint(equalTo: self.statementToDocumentLabel.bottomAnchor),
            self.statementToBankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementToBankLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementToAccountLabel.topAnchor.constraint(equalTo: self.statementToBankLabel.bottomAnchor),
            self.statementToAccountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementToAccountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementDescriptionTitleLabel.topAnchor.constraint(equalTo: self.statementToAccountLabel.bottomAnchor, constant: 24),
            self.statementDescriptionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementDescriptionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.statementDescriptionLabel.topAnchor.constraint(equalTo: self.statementDescriptionTitleLabel.bottomAnchor, constant: 4),
            self.statementDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.statementDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            self.shareIntroButtonStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.shareIntroButtonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.shareIntroButtonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.shareIntroButtonStack.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}
