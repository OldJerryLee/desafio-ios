//
//  StatementDetailsViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import UIKit

class StatementDetailsViewController: UIViewController {
    
    let userDefaultsManager = UserDefaultsManager()
    var statementDetailsScreen: StatementDetailsView?
    private let viewModel: StatementDetailsViewModel = StatementDetailsViewModel()
    
    override func loadView() {
        self.statementDetailsScreen = StatementDetailsView()
        self.view = self.statementDetailsScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statementDetailsScreen?.delegate(delegate: self)
        self.viewModel.delegate(delegate: self)
        setupNavigationBar()
        viewModel.fetchStatementDetail(id: userDefaultsManager.getStatementId() ?? "", token: userDefaultsManager.getToken() ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .coraGray
        appearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont(name: CustomFont.avenir, size: 14),
                NSAttributedString.Key.foregroundColor: UIColor.coraGrayText
        ]
        
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        navigationItem.hidesBackButton = true
        
        navigationItem.title = "Detalhes da transferência"
        
        let customBackButton = UIButton(type: .system)
        customBackButton.setImage(UIImage(named: "ic_chevron-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        customBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: customBackButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension StatementDetailsViewController: StatementDetailsViewDelegate {
    func shareDetailsButton() {
        print("Compartilhar comprovante")
    }
}

extension StatementDetailsViewController: StatementDetailsViewModelProtocol {
    func success() {
        statementDetailsScreen?.setDetailsInfo(statementDetails: viewModel.statemenDetails)
    }
    
    func error(message: String) {
        print(message)
    }
}
