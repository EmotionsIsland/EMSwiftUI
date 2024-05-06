//
//  Network.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    @available(*, deprecated, message: "no useless combine")
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T: Decodable
    func getData<T: Decodable>(with url: URL, _ type: T.Type) async throws -> T
    func getData(url: URL) async throws -> Data
}

final class Network: NetworkProtocol {
    ///комбайн? ... мне не нужен. Хщ, комбайн ... со всех сторон ... тьфу ...
    ///... я комбайны ... зае...
    ///
    ///ну зачем он тут нужен? тут же не юикит с 13 таргетом...
    ///можно же, сделать нормальные асинхронные функции, при ошибке в которых потом не надо будет копаться в стактрейсе из 20 вызовов.
    ///ну у вас же декларативный интерфейс, почему нельзя писать декларативно и функции????
    ///типо функция взяла, и вернула ответ, все. тут же нет обсервинга интернет урла,  с рективным обновлением контента...
    @available(*, deprecated, message: "no useless combine")
    func getData<T>(with url: URL, _ type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(self.handleOutput)
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getData<T: Decodable>(with url: URL, _ type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        let dataDecoded = try decoder.decode(type.self, from: data)
        return dataDecoded
    }
    
    func getData(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
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
