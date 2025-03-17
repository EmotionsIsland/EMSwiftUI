//
//  Network.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}

final class Network: NetworkProtocol {
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(self.handleOutput)
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
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
