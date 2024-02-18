//
//  Toilet.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import CoreLocation

struct Toilet {
    let address: String?
    let openTime: String?
    let pmrAccess: Bool
    let geolocalisation: CLLocation
    let currentPosition: CLLocation?
}

extension RemoteToilet {
    func toDomain(with currentPosition: CLLocation?) -> Toilet {
        return Toilet(
            address: adresse,
            openTime: horaire?.rawValue,
            pmrAccess: accesPmr?.boolean ?? false,
            geolocalisation: CLLocation(latitude: geoPoint2D[0], longitude: geoPoint2D[1]),
            currentPosition: currentPosition
        )
    }
}
