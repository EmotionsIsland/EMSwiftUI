//
//  Network.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func getData<T: Decodable>(with url: URL, _ type: T.Type) async throws -> T
    func getData(url: URL) async throws -> Data
}

final class Network: NetworkProtocol {
    func getData<T: Decodable>(with url: URL, _ type: T.Type) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let dataDecoded = try decoder.decode(type.self, from: data)
        return dataDecoded
    }
    
    func getData(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

extension Network {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badURL)
        }
        
        return output.data
    }
}
