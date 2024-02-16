//
//  ToiletListUseCase.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletListUseCase {
    func fetchToilets() async -> [Toilet]
}

final class ToiletListUseCaseImpl: ToiletListUseCase {
    private let repository: ToiletsRepository

    init(repository: ToiletsRepository) {
        self.repository = repository
    }

    func fetchToilets() async -> [Toilet] {
        do {
            return try await repository.fetchToilets(start: 0, rows: 1000).map({ $0.toDomain() })
        }
        catch(let error) {
            print(error)
        }
        return []
    }
}
