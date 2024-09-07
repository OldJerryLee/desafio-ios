//
//  StatementScreenView.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import UIKit

protocol StatementScreenViewDelegate: AnyObject {
    func filterButton()
    func refreshAction()
}

final class StatementScreenView: UIView {
    
    private lazy var allStatementsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tudo", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenirBold, size: 14)
        button.setTitleColor(.coraPink, for: .normal)
        button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var inStatementsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrada", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenir, size: 14)
        button.setTitleColor(.coraGrayText, for: .normal)
        button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var outStatementsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Saída", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenir, size: 14)
        button.setTitleColor(.coraGrayText, for: .normal)
        button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var futureStatementsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Futuro", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.avenir, size: 14)
        button.setTitleColor(.coraGrayText, for: .normal)
        button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var filterStatementsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_filter")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.tintColor = .coraPink
        return button
    }()
    
    private lazy var filterButtonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [allStatementsButton,
                                                   inStatementsButton,
                                                   outStatementsButton,
                                                   futureStatementsButton,
                                                   UIView(),
                                                   filterStatementsButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.backgroundColor = .clear
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stack.spacing = 32
        stack.setCustomSpacing(0, after: futureStatementsButton)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var statementTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StatementTableViewCell.self, forCellReuseIdentifier: StatementTableViewCell.identifier)
        tableView.register(StatementTableViewCellTemplate.self, forCellReuseIdentifier: StatementTableViewCellTemplate.identifier)
        tableView.separatorStyle = .none
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private weak var delegate: StatementScreenViewDelegate?
    private var loginButtonBottomConstraint: NSLayoutConstraint?
    private var isPasswordHidden: Bool = true
    
    func delegate(delegate: StatementScreenViewDelegate?) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.configSuperView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackGround() {
        self.backgroundColor = .coraWhite
    }
    
    private func configSuperView() {
        self.addSubview(self.filterButtonsStack)
        self.addSubview(self.statementTableView)
    }
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        statementTableView.delegate = delegate
        statementTableView.dataSource = dataSource
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.filterButtonsStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.filterButtonsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.filterButtonsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.filterButtonsStack.heightAnchor.constraint(equalToConstant: 55),
            
            statementTableView.topAnchor.constraint(equalTo: self.filterButtonsStack.bottomAnchor),
            statementTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            statementTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            statementTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc private func tappedFiltersButtons() {
        delegate?.filterButton()
    }
    
    @objc private func refreshAction() {
        delegate?.refreshAction()
    }
}
