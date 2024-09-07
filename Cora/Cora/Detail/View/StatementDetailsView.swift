//
//  StatementDetailsView.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import UIKit

protocol StatementDetailsViewDelegate: AnyObject {
    func shareDetailsButton()
}

final class StatementDetailsView: UIView {
    
    private weak var delegate: StatementDetailsViewDelegate?
    
    func delegate(delegate: StatementDetailsViewDelegate?) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpContraints()
        self.startPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var statementDetailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_arrow-up-out")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var statementTitleBoldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Transferência enviada"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementValueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Valor"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "R$ 154,00"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDateTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Data"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Hoje - 12/10/2019"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "De"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Dev iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromDocumentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "CPF 123.456.789-10"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromBankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Banco iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementFromAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Agência 1234 - Conta 12345-6"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Para"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Chapter iOS"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToDocumentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "CPF 123.456.789-10"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToBankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Banco Cora"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementToAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Agência 1234 - Conta 12345-6"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDescriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraDarkerGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Descrição"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var statementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        label.text = "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies."
        label.numberOfLines = 3
        return label
    }()
    
    lazy var shareButtonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraWhite
        label.font = UIFont(name: CustomFont.avenirBold, size: 16)
        label.text = "Compartilhar comprovante"
        label.numberOfLines = 1
        return label
    }()
    
    lazy var shareButtonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_share-ios")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var shareIntroButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shareButtonLabel, UIView(), shareButtonImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .coraPink
        stack.layer.cornerRadius = 16
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedRegister))
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20)
        return stack
    }()
    
    @objc private func tappedRegister() {
        self.delegate?.shareDetailsButton()
    }
    
    private func configBackGround(){
        self.backgroundColor = .coraWhite
    }
    
    private func configSuperView() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(statementDetailImage)
        self.contentView.addSubview(statementTitleBoldLabel)
        self.contentView.addSubview(statementValueTitleLabel)
        self.contentView.addSubview(statementValueLabel)
        self.contentView.addSubview(statementDateTitleLabel)
        self.contentView.addSubview(statementDateLabel)
        self.contentView.addSubview(statementFromTitleLabel)
        self.contentView.addSubview(statementFromLabel)
        self.contentView.addSubview(statementFromDocumentLabel)
        self.contentView.addSubview(statementFromBankLabel)
        self.contentView.addSubview(statementFromAccountLabel)
        self.contentView.addSubview(statementToTitleLabel)
        self.contentView.addSubview(statementToLabel)
        self.contentView.addSubview(statementToDocumentLabel)
        self.contentView.addSubview(statementToBankLabel)
        self.contentView.addSubview(statementToAccountLabel)
        self.contentView.addSubview(statementDescriptionTitleLabel)
        self.contentView.addSubview(statementDescriptionLabel)
        self.contentView.addSubview(shareIntroButtonStack)
    }
    
    private func setUpContraints(){
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.statementDetailImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            self.statementDetailImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.statementDetailImage.heightAnchor.constraint(equalToConstant: 24),
            self.statementDetailImage.widthAnchor.constraint(equalToConstant: 24),
            
            self.statementTitleBoldLabel.centerYAnchor.constraint(equalTo: self.statementDetailImage.centerYAnchor),
            self.statementTitleBoldLabel.leadingAnchor.constraint(equalTo: self.statementDetailImage.trailingAnchor, constant: 12),
            self.statementTitleBoldLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            
            self.statementValueTitleLabel.topAnchor.constraint(equalTo: self.statementDetailImage.bottomAnchor, constant: 24),
            self.statementValueTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementValueLabel.topAnchor.constraint(equalTo: self.statementValueTitleLabel.bottomAnchor, constant: 8),
            self.statementValueLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementDateTitleLabel.topAnchor.constraint(equalTo: self.statementValueLabel.bottomAnchor, constant: 24),
            self.statementDateTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementDateLabel.topAnchor.constraint(equalTo: self.statementDateTitleLabel.bottomAnchor, constant: 8),
            self.statementDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementFromTitleLabel.topAnchor.constraint(equalTo: self.statementDateLabel.bottomAnchor, constant: 24),
            self.statementFromTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementFromLabel.topAnchor.constraint(equalTo: self.statementFromTitleLabel.bottomAnchor, constant: 8),
            self.statementFromLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementFromDocumentLabel.topAnchor.constraint(equalTo: self.statementFromLabel.bottomAnchor, constant: 8),
            self.statementFromDocumentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementFromBankLabel.topAnchor.constraint(equalTo: self.statementFromDocumentLabel.bottomAnchor, constant: 8),
            self.statementFromBankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementFromAccountLabel.topAnchor.constraint(equalTo: self.statementFromBankLabel.bottomAnchor, constant: 8),
            self.statementFromAccountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementToTitleLabel.topAnchor.constraint(equalTo: self.statementFromAccountLabel.bottomAnchor, constant: 24),
            self.statementToTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementToLabel.topAnchor.constraint(equalTo: self.statementToTitleLabel.bottomAnchor, constant: 8),
            self.statementToLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementToDocumentLabel.topAnchor.constraint(equalTo: self.statementToLabel.bottomAnchor, constant: 8),
            self.statementToDocumentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementToBankLabel.topAnchor.constraint(equalTo: self.statementToDocumentLabel.bottomAnchor, constant: 8),
            self.statementToBankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementToAccountLabel.topAnchor.constraint(equalTo: self.statementToBankLabel.bottomAnchor, constant: 8),
            self.statementToAccountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementDescriptionTitleLabel.topAnchor.constraint(equalTo: self.statementToAccountLabel.bottomAnchor, constant: 24),
            self.statementDescriptionTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            
            self.statementDescriptionLabel.topAnchor.constraint(equalTo: self.statementDescriptionTitleLabel.bottomAnchor, constant: 8),
            self.statementDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.statementDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            
            self.shareIntroButtonStack.topAnchor.constraint(equalTo: self.statementDescriptionLabel.bottomAnchor, constant: 32),
            self.shareIntroButtonStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            self.shareIntroButtonStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24)
        ])
        
        self.contentView.bottomAnchor.constraint(equalTo: self.shareIntroButtonStack.bottomAnchor, constant: 24).isActive = true
    }
    
    public func setDetailsInfo(statementDetails: StatementDetailsResponse?) {
        if let statementDetails = statementDetails {
            statementTitleBoldLabel.text = statementDetails.label
            statementValueLabel.text = formatAmount(statementDetails.amount)
            statementDateLabel.text = formatDate(from: statementDetails.dateEvent)
            
            statementFromLabel.text = statementDetails.sender.name
            
            let senderDocumentFormattedNumber = applyDocumentFormat(documentNumber: statementDetails.sender.documentNumber, documentType: statementDetails.sender.documentType)
            
            statementFromDocumentLabel.text = senderDocumentFormattedNumber
            statementFromBankLabel.text = statementDetails.sender.bankName
            statementFromAccountLabel.text = "Agência \(statementDetails.sender.agencyNumber) - Conta \(statementDetails.sender.accountNumber)-\(statementDetails.sender.accountNumberDigit)"
            
            let recipientDocumentFormattedNumber = applyDocumentFormat(documentNumber: statementDetails.recipient.documentNumber, documentType: statementDetails.recipient.documentType)
            
            statementToLabel.text = statementDetails.recipient.name
            statementToDocumentLabel.text = recipientDocumentFormattedNumber
            statementToBankLabel.text = statementDetails.recipient.bankName
            statementToAccountLabel.text = "Agência \(statementDetails.recipient.agencyNumber) - Conta \(statementDetails.recipient.accountNumber)-\(statementDetails.recipient.accountNumberDigit)"
            
            statementDescriptionLabel.text = statementDetails.description
            
            stopPlaceholder()
        }
    }
    
    private func applyDocumentFormat(documentNumber: String, documentType: String) -> String {
        if documentType == "CPF" {
            return "\(documentType) \(documentNumber.applyingCPFFormat())"
        } else {
            return "\(documentType) \(documentNumber.applyingCNPJFormat())"
        }
    }
    
    private func formatAmount(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")

        let decimalAmount = Double(amount) / 100.0
        if let formattedAmount = formatter.string(from: NSNumber(value: decimalAmount)) {
            return formattedAmount
        }
        return "R$ 0,00"
    }
    
    private func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return "Data inválida"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEEE"
        dayOfWeekFormatter.locale = Locale(identifier: "pt_BR")
        
        let dayOfWeek = dayOfWeekFormatter.string(from: date).capitalized
        let formattedDate = dateFormatter.string(from: date)
        
        let calendar = Calendar.current
        let isToday = calendar.isDateInToday(date)
        
        if isToday {
            return "Hoje - \(formattedDate)"
        } else {
            return "\(dayOfWeek) - \(formattedDate)"
        }
    }
    
    func startPlaceholder() {
        shareIntroButtonStack.isHidden = true
        statementDetailImage.isHidden = true
        
        statementTitleBoldLabel.backgroundColor = .coraPlaceholderGray
        statementValueTitleLabel.backgroundColor = .coraPlaceholderGray
        statementValueLabel.backgroundColor = .coraPlaceholderGray
        statementDateTitleLabel.backgroundColor = .coraPlaceholderGray
        statementDateLabel.backgroundColor = .coraPlaceholderGray
        statementFromTitleLabel.backgroundColor = .coraPlaceholderGray
        statementFromLabel.backgroundColor = .coraPlaceholderGray
        statementFromDocumentLabel.backgroundColor = .coraPlaceholderGray
        statementFromBankLabel.backgroundColor = .coraPlaceholderGray
        statementFromAccountLabel.backgroundColor = .coraPlaceholderGray
        statementToTitleLabel.backgroundColor = .coraPlaceholderGray
        statementToLabel.backgroundColor = .coraPlaceholderGray
        statementToDocumentLabel.backgroundColor = .coraPlaceholderGray
        statementToBankLabel.backgroundColor = .coraPlaceholderGray
        statementToAccountLabel.backgroundColor = .coraPlaceholderGray
        statementDescriptionTitleLabel.backgroundColor = .coraPlaceholderGray
        statementDescriptionLabel.backgroundColor = .coraPlaceholderGray
        
        statementTitleBoldLabel.textColor = .coraPlaceholderGray
        statementValueTitleLabel.textColor = .coraPlaceholderGray
        statementValueLabel.textColor = .coraPlaceholderGray
        statementDateTitleLabel.textColor = .coraPlaceholderGray
        statementDateLabel.textColor = .coraPlaceholderGray
        statementFromTitleLabel.textColor = .coraPlaceholderGray
        statementFromLabel.textColor = .coraPlaceholderGray
        statementFromDocumentLabel.textColor = .coraPlaceholderGray
        statementFromBankLabel.textColor = .coraPlaceholderGray
        statementFromAccountLabel.textColor = .coraPlaceholderGray
        statementToTitleLabel.textColor = .coraPlaceholderGray
        statementToLabel.textColor = .coraPlaceholderGray
        statementToDocumentLabel.textColor = .coraPlaceholderGray
        statementToBankLabel.textColor = .coraPlaceholderGray
        statementToAccountLabel.textColor = .coraPlaceholderGray
        statementDescriptionTitleLabel.textColor = .coraPlaceholderGray
        statementDescriptionLabel.textColor = .coraPlaceholderGray
    }
    
    func stopPlaceholder() {
        shareIntroButtonStack.isHidden = false
        statementDetailImage.isHidden = false
        
        statementTitleBoldLabel.backgroundColor = .clear
        statementValueTitleLabel.backgroundColor = .clear
        statementValueLabel.backgroundColor = .clear
        statementDateTitleLabel.backgroundColor = .clear
        statementDateLabel.backgroundColor = .clear
        statementFromTitleLabel.backgroundColor = .clear
        statementFromLabel.backgroundColor = .clear
        statementFromDocumentLabel.backgroundColor = .clear
        statementFromBankLabel.backgroundColor = .clear
        statementFromAccountLabel.backgroundColor = .clear
        statementToTitleLabel.backgroundColor = .clear
        statementToLabel.backgroundColor = .clear
        statementToDocumentLabel.backgroundColor = .clear
        statementToBankLabel.backgroundColor = .clear
        statementToAccountLabel.backgroundColor = .clear
        statementDescriptionTitleLabel.backgroundColor = .clear
        statementDescriptionLabel.backgroundColor = .clear
        
        statementTitleBoldLabel.textColor = .coraDarkerGrayText
        statementValueTitleLabel.textColor = .coraDarkerGrayText
        statementValueLabel.textColor = .coraDarkerGrayText
        statementDateTitleLabel.textColor = .coraDarkerGrayText
        statementDateLabel.textColor = .coraDarkerGrayText
        statementFromTitleLabel.textColor = .coraDarkerGrayText
        statementFromLabel.textColor = .coraDarkerGrayText
        statementFromDocumentLabel.textColor = .coraGrayText
        statementFromBankLabel.textColor = .coraGrayText
        statementFromAccountLabel.textColor = .coraGrayText
        statementToTitleLabel.textColor = .coraDarkerGrayText
        statementToLabel.textColor = .coraDarkerGrayText
        statementToDocumentLabel.textColor = .coraGrayText
        statementToBankLabel.textColor = .coraGrayText
        statementToAccountLabel.textColor = .coraGrayText
        statementDescriptionTitleLabel.textColor = .coraDarkerGrayText
        statementDescriptionLabel.textColor = .coraGrayText
    }
}

