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
    enum Constant {
        static let keyLocation = "keyLocation"
    }

    private var lastLocation: CLLocation? {
        get {
            guard let coordinates = UserDefaults.standard.value(forKey: Constant.keyLocation) as? [Double] else { return nil }
            return CLLocation(latitude: coordinates[0], longitude: coordinates[1])
        }
        set {
            guard let newValue else { return }
            let coordinates: [Double] = [newValue.coordinate.latitude, newValue.coordinate.longitude]
            UserDefaults.standard.setValue(coordinates, forKey: Constant.keyLocation)
        }
    }

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
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            delegate?.didUpdateLocation()
        default: break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
