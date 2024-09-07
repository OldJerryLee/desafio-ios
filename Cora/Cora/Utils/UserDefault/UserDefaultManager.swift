//
//  UserDefaultManager.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

class UserDefaultsManager {
    
    private let userDefaults = UserDefaults.standard
    private let cpfKey = "userCPF"
    private let passwordKey = "userPassword"
    private let tokenKey = "userToken"
    private let statementKey = "statementId"
    
    func saveCPF(_ cpf: String) {
        userDefaults.set(cpf, forKey: cpfKey)
    }
    
    func getCPF() -> String? {
        return userDefaults.string(forKey: cpfKey)
    }
    
    func clearCPF() {
        userDefaults.removeObject(forKey: cpfKey)
    }
    
    func savePassword(_ password: String) {
        userDefaults.set(password, forKey: passwordKey)
    }
    
    func getPassword() -> String? {
        return userDefaults.string(forKey: passwordKey)
    }
    
    func clearPassword() {
        userDefaults.removeObject(forKey: passwordKey)
    }
    
    func saveToken(_ token: String) {
        userDefaults.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return userDefaults.string(forKey: tokenKey)
    }
    
    func clearToken() {
        userDefaults.removeObject(forKey: tokenKey)
    }
    
    func saveStatementId(_ id: String) {
        userDefaults.set(id, forKey: statementKey)
    }
    
    func getStatementId() -> String? {
        return userDefaults.string(forKey: statementKey)
    }
    
    func clearStatementId() {
        userDefaults.removeObject(forKey: statementKey)
    }
}
