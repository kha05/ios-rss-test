//
//  ToiletsRepository.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletsRepository {
    func fetchToilets(start: Int, rows: Int) async throws -> [RemoteToilet]
}
