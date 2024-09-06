//
//  NetworkLayer.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import Foundation

protocol NetworkLayer {
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}
