//
//  StatementDetailsViewModel.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import Foundation

protocol StatementDetailsViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

final class StatementDetailsViewModel {
    
    private var service: StatementDetailsService = StatementDetailsService()
    var statemenDetails: StatementDetailsResponse?
    private weak var delegate: StatementDetailsViewModelProtocol?
    
    public func delegate(delegate: StatementDetailsViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchStatementDetail(id: String, token: String) {
        service.getStatementDetails(id: id, token: token) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                statemenDetails = response
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
}
