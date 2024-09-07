//
//  StatementDetailsResponse.swift
//  Cora
//
//  Created by Fabricio Pujol on 07/09/24.
//

import Foundation

struct StatementDetailsResponse: Codable {
    let description: String
    let label: String
    let amount: Int
    let counterPartyName: String
    let id: String
    let dateEvent: String
    let recipient: Recipient
    let sender: Sender
    let status: String
}

struct Recipient: Codable {
    let bankName: String
    let bankNumber: String
    let documentNumber: String
    let documentType: String
    let accountNumberDigit: String
    let agencyNumberDigit: String
    let agencyNumber: String
    let name: String
    let accountNumber: String
}

struct Sender: Codable {
    let bankName: String
    let bankNumber: String
    let documentNumber: String
    let documentType: String
    let accountNumberDigit: String
    let agencyNumberDigit: String
    let agencyNumber: String
    let name: String
    let accountNumber: String
}
