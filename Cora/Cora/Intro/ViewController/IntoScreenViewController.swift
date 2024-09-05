//
//  IntoScreenViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 31/08/24.
//

import UIKit

class IntoScreenViewController: UIViewController {
    
    var introScreen:IntroscreenView?
    
    override func loadView() {
        self.introScreen = IntroscreenView()
        self.view = self.introScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.introScreen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension IntoScreenViewController: LoginScreenDelegate {
    func signupIntroButton() {
        //TODO: Not mentioned on figma.
        print("Ir para Registrar")
    }
    
    func loginIntroButton() {
        let viewController:DocumentViewController = DocumentViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
