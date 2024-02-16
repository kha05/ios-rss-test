//
//  ToiletsRequestDTO.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

struct RemoteToiletsRequest: Encodable {
    let start: Int
    let rows: Int
}
