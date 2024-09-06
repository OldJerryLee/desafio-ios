//
//  DocumentViewModel.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

class DocumentViewModel {
    
    private var documentNumber: String = ""
    var documentCharacterLimit: Int = 14
    
    func setCPFNumbers(documentNumber: String) {
        self.documentNumber = documentNumber.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
    }
    
    func getCPFNumbers() -> String {
        return documentNumber
    }
}
