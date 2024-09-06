//
//  RequestBuilder.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest
}
