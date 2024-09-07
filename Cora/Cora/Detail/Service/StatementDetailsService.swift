//
//  StatementDetailsService.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import Foundation

class StatementDetailsService {
    func getStatementDetails(id: String,token: String,completion: @escaping (Result<StatementDetailsResponse,NetworkError>) -> Void) {
        let urlString: String = "https://api.challenge.stage.cora.com.br/challenge/list:\(id)"
        let endpoint = Endpoint(url: urlString,
                                method: .get,
                                headers: ["apikey":"bf3f06390a035941138166583c1598c7","token":token])
        
        ServiceManager.shared.request(with: endpoint, decodeType: StatementDetailsResponse.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
