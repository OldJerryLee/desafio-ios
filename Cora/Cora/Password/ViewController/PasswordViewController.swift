//
//  PasswordViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 05/09/24.
//

import UIKit

class PasswordViewController: UIViewController {

    private var passwordScreen:PasswordScreenView?
    private let userDefaultsManager = UserDefaultsManager()
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
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - PasswordViewModelProtocol
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
