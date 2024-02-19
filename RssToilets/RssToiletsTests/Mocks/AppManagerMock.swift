//
//  AppManagerMock.swift
//  RssToiletsTests
//
//  Created by Ha Kevin on 18/02/2024.
//

import Foundation
import CoreLocation
@testable import RssToilets

class AppLocationMock: AppLocation {
    var delegate: RssToilets.AppLocationDelegate?
    
    func getUserLocation() async -> CLLocation? {
        return CLLocation(latitude: 100.1, longitude: 100.1)
    }
}
