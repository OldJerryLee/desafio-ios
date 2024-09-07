//
//  TokenManagerService.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import Foundation

class TokenManagerService {
    func refreshToken(token: String,completion: @escaping (Result<AuthResponse,NetworkError>) -> Void) {
        let urlString: String = "https://api.challenge.stage.cora.com.br/challenge/auth"
        let endpoint = Endpoint(url: urlString,
                                method: .post,
                                headers: ["apikey":"bf3f06390a035941138166583c1598c7","Accept":"application/json","Content-Type":"application/json"],
                                parameters: Parameters.dictionary(["token":token]))
        
        ServiceManager.shared.request(with: endpoint, decodeType: AuthResponse.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
