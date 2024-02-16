//
//  NetworkConfig.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL? { get }
}

struct ApiDataNetworkConfig: NetworkConfigurable {
    let baseURL: URL?

     init(baseURL: URL?) {
        self.baseURL = baseURL
    }
}
