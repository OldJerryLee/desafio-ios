//
//  PasswordViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 05/09/24.
//

import UIKit

class PasswordViewController: UIViewController {

    var passwordScreen:PasswordScreenView?
    let userDefaultsManager = UserDefaultsManager()
    private let viewModel: PasswordViewModel = PasswordViewModel()
    
    override func loadView() {
        self.passwordScreen = PasswordScreenView()
        self.view = self.passwordScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordScreen?.delegate(delegate: self)
        self.passwordScreen?.configTextFieldDelegate(delegate: self)
        self.viewModel.delegate(delegate: self)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        passwordScreen?.passwordTextField.becomeFirstResponder()
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
        
        navigationItem.title = "Login Cora"
        
        let customBackButton = UIButton(type: .system)
        customBackButton.setImage(UIImage(named: "ic_chevron-left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        customBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: customBackButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
//    private func setupNavigationBarItems() {
//
//
//        setupLeftNavigationBar()
//        setupRightNavigationBar()
//    }
    
//    private func setupLeftNavigationBar() {
//        let lockButton = UIButton(type: .system)
//        lockButton.setImage(UIImage(named: "secure-cloud-50.png"), for: .normal)
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: lockButton)
//    }
//
//    private func setupRightNavigationBar() {
//        let rebelButton = UIButton(type: .system)
//        rebelButton.setImage(UIImage(named: "sw-rebel-48.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
//
//        let empireButton = UIButton(type: .system)
//        empireButton.setImage(UIImage(named: "sw-empire-48.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
//
//
//        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rebelButton), UIBarButtonItem(customView: empireButton)]
//    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension PasswordViewController: PasswordViewModelProtocol {
    func success(token: String) {
        userDefaultsManager.saveToken(token)
        let viewController: StatementScreenViewController = StatementScreenViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func error(message: String) {
        print(message)
    }
}

// MARK: - PasswordScreenDelegate
extension PasswordViewController: PasswordScreenDelegate {
    func forgotPasswordButton() {
        print("Ir para Esqueci minha senha")
    }
    
    func nextButton() {
        if let passwordString = passwordScreen?.passwordTextField.text {
            userDefaultsManager.savePassword(passwordString)
        }
        
        viewModel.fetchToken(document: userDefaultsManager.getCPF() ?? "",
                             password: userDefaultsManager.getPassword() ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension PasswordViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

        if newText.count >= viewModel.passwordCharactersLimit {
            passwordScreen?.enableButton()
        } else {
            passwordScreen?.disableButton()
        }

        return newText.count <= viewModel.passwordCharactersLimit
    }
}
