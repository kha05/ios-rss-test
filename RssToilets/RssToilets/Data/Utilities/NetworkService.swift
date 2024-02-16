//
//  WebService.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case servorError
}

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
}

protocol NetworkService: AnyObject {
    func execute<T: Decodable>(endpoint: Requestable) async throws -> Result<T?, Error>
}

class NetworkServiceImpl: NetworkService {
    private let config: NetworkConfigurable
    private lazy var jsonDecoder = {
        return JSONDecoder()
    }()

    init(config: NetworkConfigurable) {
        self.config = config
    }

    func execute<T: Decodable>(endpoint: Requestable) async throws -> Result<T?, Error> {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return self.decode(data: data, decoder: jsonDecoder)
        } catch {
            throw NetworkError.invalidRequest
        }
    }
}

private extension NetworkServiceImpl {
    func decode<T: Decodable>(
        data: Data?,
        decoder: JSONDecoder
    ) -> Result<T, Error> {
        do {
            guard let data = data else { return .failure(DataTransferError.noResponse) }
            let result: T = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch {
            return .failure(DataTransferError.parsing(error))
        }
    }

}
