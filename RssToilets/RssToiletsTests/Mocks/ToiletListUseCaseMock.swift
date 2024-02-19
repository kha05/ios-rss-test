//
//  ToiletListUseCaseMock.swift
//  RssToiletsTests
//
//  Created by Ha Kevin on 18/02/2024.
//

import Foundation
import CoreLocation
@testable import RssToilets

final class ToiletListUseCaseMock: ToiletListUseCase {
    public var toilets: [Toilet] = []

    func fetchToilets(from currentPosition: CLLocation?) async -> [RssToilets.Toilet] {
        return toilets
    }
}
