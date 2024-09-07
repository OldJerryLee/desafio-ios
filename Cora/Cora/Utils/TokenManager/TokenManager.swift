//
//  TokenManager.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import Combine
import Foundation

class TokenManager: ObservableObject {
    static let shared = TokenManager()
    private var service: TokenManagerService = TokenManagerService()
    
    @Published var isRefreshingToken = false
    private var accessToken: String?
    private var expirationDate: Date?
    private var refreshTimer: Timer?
    
    func saveToken(token: String, expiresIn: TimeInterval) {
        self.accessToken = token
        self.expirationDate = Date().addingTimeInterval(expiresIn)
        
        startRefreshTimer(timeBeforeExpiration: expiresIn - 10)
    }
    
    private func startRefreshTimer(timeBeforeExpiration: TimeInterval) {
        refreshTimer?.invalidate()
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: timeBeforeExpiration, repeats: false) { [weak self] _ in
            self?.attemptTokenRefresh()
        }
    }
    
    private func attemptTokenRefresh() {
        guard let token = accessToken else {
            print("Erro: Não há token para renovar.")
            return
        }
        
        refreshToken(with: token) { success in
            if !success {
                print("Falha ao renovar o token automaticamente.")
            }
        }
    }
    
    func getToken(completion: @escaping (String?) -> Void) {
        guard let token = accessToken, let expirationDate = expirationDate else {
            completion(nil)
            return
        }
        
        if Date() < expirationDate {
            completion(token)
        } else {
            refreshToken(with: token) { success in
                if success {
                    completion(self.accessToken)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func refreshToken(with currentToken: String, completion: @escaping (Bool) -> Void) {
        guard !isRefreshingToken else { return }
        
        isRefreshingToken = true
        
        service.refreshToken(token: currentToken) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let token):
                DispatchQueue.main.async {
                    self.isRefreshingToken = false
                    self.saveToken(token: token.token, expiresIn: 60)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
