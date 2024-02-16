//
//  ToiletViewModel.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import CoreLocation

struct ToiletViewModel: Equatable {
    let address: String
    let openingHour: String
    let isPrmFriendly: Bool
    let distance: String
}

extension Toilet {
    func toViewModel(with location: CLLocation?) -> ToiletViewModel {
        return ToiletViewModel(
            address: address,
            openingHour: "Ouverture: \(openTime)",
            isPrmFriendly: pmrAccess,
            distance: ""
        )
    }
}
