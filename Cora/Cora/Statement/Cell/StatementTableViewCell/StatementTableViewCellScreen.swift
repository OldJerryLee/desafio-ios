//
//  StatementTableViewCellScreen.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import UIKit

class StatementTableViewCellScreen: UIView {
    
    lazy var statementTypeImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ic_arrow-down-in")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .coraDarkerGrayText
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraBlue
        label.font = UIFont(name: CustomFont.avenirBold, size: 14)
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraBlue
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 14)
        return label
    }()
    
    lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coraGrayText
        label.font = UIFont(name: CustomFont.avenir, size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        setupConstraints()
    }
    
    private func configSuperView() {
        addSubview(statementTypeImage)
        addSubview(valueLabel)
        addSubview(typeLabel)
        addSubview(nameLabel)
        addSubview(hourLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statementTypeImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            statementTypeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            statementTypeImage.heightAnchor.constraint(equalToConstant: 24),
            statementTypeImage.widthAnchor.constraint(equalToConstant: 24),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            valueLabel.leadingAnchor.constraint(equalTo: statementTypeImage.trailingAnchor, constant: 16),
            
            typeLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: statementTypeImage.trailingAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: statementTypeImage.trailingAnchor, constant: 16),
            
            hourLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            hourLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
}
