//
//  StatementService.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

class StatementService {
    func getStatementList(token: String,completion: @escaping (Result<StatementListReponse,NetworkError>) -> Void) {
        let urlString: String = "https://api.challenge.stage.cora.com.br/challenge/list"
        let endpoint = Endpoint(url: urlString,
                                method: .get,
                                headers: ["apikey":"bf3f06390a035941138166583c1598c7","token":token])
        
        ServiceManager.shared.request(with: endpoint, decodeType: StatementListReponse.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
