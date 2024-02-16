//
//  APIEndpoints.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

struct APIEndpoints {

    static func getToilets(with toiletsRequest: RemoteToiletsRequest) -> Endpoint<RemoteToilets> {
        return Endpoint(
            path: "records/1.0/search/?dataset=sanisettesparis2011",
            method: .get,
            queryParameters: toiletsRequest
        )
    }
}
