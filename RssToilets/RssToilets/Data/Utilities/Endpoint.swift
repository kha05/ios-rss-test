//
//  Endpoint.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

enum HTTPMethodType: String {
    case get     = "GET"
}

enum RequestGenerationError: Error {
    case components
}

protocol Requestable {

    var path: String { get }
    var method: HTTPMethodType { get }
    var queryParameters: Encodable? { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

class Endpoint<R>: Requestable {

    let path: String
    let method: HTTPMethodType
    let queryParameters: Encodable?

    init(path: String,
         method: HTTPMethodType,
         queryParameters: Encodable? = nil) {
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
    }
}

extension Requestable {
    func url(with config: NetworkConfigurable) throws -> URL {
        let baseURL = config.baseURL.absoluteString + "/"
        let endpoint = baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        var urlQueryItems = [URLQueryItem]()

        let queryParameters = try queryParameters?.toDictionary() ?? [:]
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }

        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }

    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

private extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
