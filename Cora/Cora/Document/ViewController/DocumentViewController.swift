//
//  DocumentViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 01/09/24.
//

import UIKit

class DocumentViewController: UIViewController {

    var documentScreen:DocumentScreenView?
    
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

extension DocumentViewController: DocumentScreenDelegate {
    func nextButton() {
        print("Ir para senha")
        //Salvar documento no user default
        //Ir para tela de Senha.
        let viewController:PasswordViewController = PasswordViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension DocumentViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count > 14 {
            return false
        }
        
        let formattedText = newText.applyingCPFFormat()
        
        textField.text = formattedText
        
        if formattedText.isCPF {
            documentScreen?.enableButton()
        } else {
            documentScreen?.disableButton()
        }
        
        return false
    }
}
