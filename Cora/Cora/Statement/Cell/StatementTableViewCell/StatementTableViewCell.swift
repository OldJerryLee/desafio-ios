//
//  StatementTableViewCell.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    
    static let identifier: String = "StatementTableViewCell"

    lazy var screen: StatementTableViewCellScreen = {
        let view = StatementTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubView()
        setupConstraints()
    }
    
    private func addSubView() {
        contentView.addSubview(screen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setupHomeCell(amount: String, label: String, name: String, dateEvent: String, entry: String) {
        screen.valueLabel.text = amount
        screen.typeLabel.text = label
        screen.nameLabel.text = name
        screen.hourLabel.text = dateEvent
        
        setupColors(entry: entry)
    }
    
    private func setupColors(entry: String) {
        if entry == "CREDIT" {
            screen.valueLabel.textColor = .coraBlue
            screen.typeLabel.textColor = .coraBlue
            screen.statementTypeImage.image = UIImage(named: "ic_arrow-down-in")?.withRenderingMode(.alwaysTemplate)
        } else {
            screen.valueLabel.textColor = .coraGrayText
            screen.typeLabel.textColor = .coraGrayText
            screen.statementTypeImage.image = UIImage(named: "ic_arrow-up-out")?.withRenderingMode(.alwaysTemplate)
        }
    }
}
