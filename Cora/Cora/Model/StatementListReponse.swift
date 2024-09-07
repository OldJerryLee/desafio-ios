//
//  StatementListReponse.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

struct StatementListReponse: Codable {
    let results: [ResultStatementList]
    let itemsTotal: Int
}

struct ResultStatementList: Codable {
    let items: [Item]
    let date: String
}

struct Item: Codable {
    let id: String
    let description: String
    let label: String
    let entry: String
    let amount: Int
    let name: String
    let dateEvent: String
    let status: String
}
