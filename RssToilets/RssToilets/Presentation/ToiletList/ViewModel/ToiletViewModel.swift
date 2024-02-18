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
    let distanceFromToilet: Double?

    var adressText: String {
        var text = "🚽 "
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

    var distanceText: String? {
        guard let distanceFromToilet else {
            return nil
        }
        var distanceString: String
        if distanceFromToilet > 999 {
            distanceString = "\(String(format:"%.02f", distanceFromToilet / 1000)) km"
        } else {
            distanceString = "\(String(format:"%.02f", distanceFromToilet)) m"
        }
        return "📍 \(distanceString)"
    }
}

extension Toilet {
    func toViewModel() -> ToiletViewModel {
        return ToiletViewModel(
            address: address,
            openingHour: openTime,
            isPrmFriendly: pmrAccess,
            distanceFromToilet: currentPosition?.distance(from: geolocalisation)
        )
    }
}
