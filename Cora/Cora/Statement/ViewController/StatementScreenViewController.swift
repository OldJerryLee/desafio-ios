//
//  StatementScreenViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import UIKit

class StatementScreenViewController: UIViewController {

    var statementScreen: StatementScreenView?
    let userDefaultsManager = UserDefaultsManager()
    private let viewModel: StatementViewModel = StatementViewModel()
    
    override func loadView() {
        self.statementScreen = StatementScreenView()
        self.view = self.statementScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statementScreen?.delegate(delegate: self)
        self.viewModel.delegate(delegate: self)
        setupNavigationBar()
        statementScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        viewModel.fetchStatementList(token: userDefaultsManager.getToken() ?? "")
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
        
        navigationItem.title = "Extrato"
        
        let customBackButton = UIButton(type: .system)
        customBackButton.setImage(UIImage(named: "ic_chevron-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        customBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        let customDownloadButton = UIButton(type: .system)
        customDownloadButton.setImage(UIImage(named: "sign-out")?.withRenderingMode(.alwaysOriginal), for: .normal)
        customDownloadButton.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: customBackButton)
        let downloadButtonItem = UIBarButtonItem(customView: customDownloadButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = downloadButtonItem
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func downloadButtonPressed() {
        print("Clicou em download")
    }
}

extension StatementScreenViewController: StatementViewModelProtocol {
    func error(message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Ops, tivemos um problema", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    
    func success() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewModel.isLoading = false
            self.statementScreen?.statementTableView.reloadData()
        }
    }
}

// MARK: - StatementScreenViewDelegate
extension StatementScreenViewController: StatementScreenViewDelegate {
    func downloadButton() {
        print("Download Button")
    }
    
    func filterButton() {
        print("Filter Button")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension StatementScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !viewModel.isLoading {
            let results = viewModel.statementList?.results[indexPath.section]
            let statement = results?.items[indexPath.row]
            
            userDefaultsManager.saveStatementId(statement?.id ?? "")
            
            let viewController: StatementDetailsViewController = StatementDetailsViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.isLoading {
            return viewModel.numberOfRowsTemplate
        }
        
        return viewModel.getNumberOfRowsinSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.isLoading {
            return StatementTableViewCellTemplate()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StatementTableViewCell.identifier, for: indexPath) as? StatementTableViewCell
        let results = viewModel.statementList?.results[indexPath.section]
        let statement = results?.items[indexPath.row]
        
        guard let amount = statement?.amount,
              let label = statement?.label,
              let name = statement?.name,
              let dateEvent = statement?.dateEvent,
              let entry = statement?.entry else {
            return UITableViewCell()
        }
        
        cell?.setupHomeCell(amount: viewModel.formatAmount(amount),
                            label: label,
                            name: name,
                            dateEvent: viewModel.formatTime(from: dateEvent) ?? "", 
                            entry: entry)

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .coraGray
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32)

        let headerLabel = UILabel()
        
        if !viewModel.isLoading {
            headerLabel.text = viewModel.formatDate(from: viewModel.statementList?.results[section].date ?? "")
            headerLabel.textColor = .coraGrayText
            headerLabel.font = UIFont.systemFont(ofSize: 12)

            headerView.addSubview(headerLabel)

            headerLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if viewModel.isLoading {
            return viewModel.numberOfSectionsTemplate
        }
        
        return viewModel.numberOfSections
    }
}

//393.147.910-25
