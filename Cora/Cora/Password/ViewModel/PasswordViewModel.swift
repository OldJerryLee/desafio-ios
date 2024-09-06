//
//  PasswordViewModel.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

protocol PasswordViewModelProtocol: AnyObject {
    func success(token: String)
    func error(message: String)
}

class PasswordViewModel {
    
    private var service: PasswordService = PasswordService()
    private weak var delegate: PasswordViewModelProtocol?
    let passwordCharactersLimit: Int = 6
    
    public func delegate(delegate: PasswordViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchToken(document: String, password: String) {
        service.getToken(document: document,
                         password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let token):
                delegate?.success(token: token.token)
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
}
