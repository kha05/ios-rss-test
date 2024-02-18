//
//  ToiletViewModel.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import CoreLocation

struct ToiletViewModel: Equatable {
    let address: String?
    let openingHour: String?
    let isPrmFriendly: Bool
    let distance: String

    var adressText: String {
        var text = "📍 "
        if let address {
            text +=  address.uppercased()
        } else {
            text += "Adresse inconnue"
        }
        return text
    }

    var openingHourText: String {
        var text = "🕒 "
        if let openingHour {
            text +=  openingHour
        } else {
            text += "Horaires inconnues"
        }
        return text
    }

    var prmText: String? {
        isPrmFriendly ? "♿️" : nil
    }

    var wcText: String {
        "🚾"
    }
}

extension Toilet {
    func toViewModel(with location: CLLocation?) -> ToiletViewModel {
        return ToiletViewModel(
            address: address,
            openingHour: openTime,
            isPrmFriendly: pmrAccess,
            distance: ""
        )
    }
}
