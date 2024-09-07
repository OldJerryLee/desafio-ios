//
//  StatementTableViewCellScreenTemplate.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import UIKit

class StatementTableViewCellScreenTemplate: UIView {
    
    lazy var bigTemplateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .coraPlaceholderGray
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var smallTemplateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .coraPlaceholderGray
        view.layer.cornerRadius = 4
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        setupConstraints()
    }
    
    private func configSuperView() {
        addSubview(bigTemplateView)
        addSubview(smallTemplateView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bigTemplateView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            bigTemplateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            bigTemplateView.heightAnchor.constraint(equalToConstant: 38),
            bigTemplateView.widthAnchor.constraint(equalToConstant: 232),
            
            smallTemplateView.topAnchor.constraint(equalTo: bigTemplateView.bottomAnchor, constant: 10),
            smallTemplateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            smallTemplateView.heightAnchor.constraint(equalToConstant: 16),
            smallTemplateView.widthAnchor.constraint(equalToConstant: 165),
        ])
    }
}
