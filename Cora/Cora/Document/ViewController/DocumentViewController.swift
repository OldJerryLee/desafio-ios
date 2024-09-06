//
//  DocumentViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 01/09/24.
//

import UIKit

class DocumentViewController: UIViewController {

    var documentScreen: DocumentScreenView?
    let userDefaultsManager = UserDefaultsManager()
    private let viewModel: DocumentViewModel = DocumentViewModel()
    
    override func loadView() {
        self.documentScreen = DocumentScreenView()
        self.view = self.documentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.documentScreen?.delegate(delegate: self)
        self.documentScreen?.configTextFieldDelegate(delegate: self)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        documentScreen?.documentTextField.becomeFirstResponder()
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

extension DocumentViewController: DocumentScreenDelegate {
    func nextButton() {
        userDefaultsManager.saveCPF(viewModel.getCPFNumbers())
        let viewController:PasswordViewController = PasswordViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DocumentViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > viewModel.documentCharacterLimit {
            return false
        }
        
        let formattedText = newText.applyingCPFFormat()
        
        textField.text = formattedText
        viewModel.setCPFNumbers(documentNumber: formattedText)
        
        if formattedText.isCPF {
            documentScreen?.enableButton()
        } else {
            documentScreen?.disableButton()
        }
        
        return false
    }
}
