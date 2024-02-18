//
//  AppLocation.swift
//  RssToilets
//
//  Created by Ha Kevin on 18/02/2024.
//

import Foundation
import CoreLocation

typealias AppLocationCallback = (_ location: CLLocation?) -> Void

protocol AppLocation {
    var delegate: AppLocationDelegate? { get set }
    func getUserLocation() async -> CLLocation?
}

protocol AppLocationDelegate: AnyObject {
    func didUpdateLocation()
}

final class AppLocationImpl: NSObject, AppLocation {    
    private var lastLocation: CLLocation?
    weak var delegate: AppLocationDelegate?

    private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.activityType = .automotiveNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()

    // MARK: Init

    public override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    // MARK: Public

    func getUserLocation() async -> CLLocation? {
        if let historyLocation = lastLocation {
            return historyLocation
        } else {
            return await enableLocationServices()
        }
    }
}

// MARK: Private

private extension AppLocationImpl {
    func enableLocationServices() async -> CLLocation? {
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            enableMyWhenInUseFeatures()
        default:
            print("Fail permission to get current location of user")

        }
        return nil
    }

    func enableMyWhenInUseFeatures() {
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
}

extension AppLocationImpl: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        lastLocation = location
        delegate?.didUpdateLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.didUpdateLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
