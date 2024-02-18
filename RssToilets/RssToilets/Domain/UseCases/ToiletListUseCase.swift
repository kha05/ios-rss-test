//
//  ToiletListUseCase.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import CoreLocation

protocol ToiletListUseCase {
    func fetchToilets(from currentPosition: CLLocation?) async -> [Toilet]
}

final class ToiletListUseCaseImpl: ToiletListUseCase {
    private let repository: ToiletsRepository

    init(repository: ToiletsRepository) {
        self.repository = repository
    }

    func fetchToilets(from currentPosition: CLLocation?) async -> [Toilet] {
        do {
            return try await repository.fetchToilets(start: 0, rows: 1000).map({ $0.toDomain(with: currentPosition) })
        }
        catch(let error) {
            print(error)
        }
        return []
    }
}
