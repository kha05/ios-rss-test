//
//  RssToiletsTests.swift
//  RssToiletsTests
//
//  Created by Ha Kevin on 16/02/2024.
//

import XCTest
import CoreLocation
@testable import RssToilets

final class ToiletListPresenterTests: XCTestCase {

    private var locationManagerMock = AppLocationMock()
    private var useCaseMock = ToiletListUseCaseMock()

    func test_fetchToiletList_whenLocationIsNotAuthorized_shouldSuccessWithoutLocation() {
        // Given
        let expectation = XCTestExpectation(description: "")
        let presenter = ToiletListPresenterImpl(useCase: useCaseMock, appLocation: locationManagerMock)
        useCaseMock.toilets = [
            Toilet(
                address: "Republique",
                openTime: "8 h / 16 h",
                pmrAccess: true,
                geolocalisation: CLLocation(latitude: 48.878670498826594, longitude: 2.3585432997295994),
                currentPosition: nil
            ),
            Toilet(
                address: "Opera",
                openTime: "24 h / 24",
                pmrAccess: false,
                geolocalisation: CLLocation(latitude: 48.86112313165573, longitude: 2.3670324237623683),
                currentPosition: nil
            )
        ]

        let expectedViewModels = [
            ToiletViewModel(
                address: "Republique",
                openingHour: "8 h / 16 h",
                isPrmFriendly: true,
                distanceFromToilet: nil
            ),
            ToiletViewModel(
                address: "Opera",
                openingHour: "24 h / 24",
                isPrmFriendly: false,
                distanceFromToilet: nil
            )
        ]

        // When
        presenter.fetchToilets()

        // Then
        presenter.didUpdate = {
            expectation.fulfill()
            XCTAssertEqual(presenter.viewModelsFiltered, expectedViewModels)
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_fetchToiletList_whenLocationIsAuthorized_shouldSuccessWithLocation() {
        // Given
        let expectation = XCTestExpectation(description: "")
        let presenter = ToiletListPresenterImpl(useCase: useCaseMock, appLocation: locationManagerMock)
        useCaseMock.toilets = [
            Toilet(
                address: "Republique",
                openTime: "8 h / 16 h",
                pmrAccess: true,
                geolocalisation: CLLocation(latitude: 48.878670498826594, longitude: 2.3585432997295994),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            ),
            Toilet(
                address: "Opera",
                openTime: "24 h / 24",
                pmrAccess: false,
                geolocalisation: CLLocation(latitude: 48.86112313165573, longitude: 2.3670324237623683),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            )
        ]

        let expectedViewModels = [
            ToiletViewModel(
                address: "Republique",
                openingHour: "8 h / 16 h",
                isPrmFriendly: true,
                distanceFromToilet: 0
            ),
            ToiletViewModel(
                address: "Opera",
                openingHour: "24 h / 24",
                isPrmFriendly: false,
                distanceFromToilet: 0
            )
        ]

        // When
        presenter.fetchToilets()

        // Then
        presenter.didUpdate = {
            expectation.fulfill()
            XCTAssertEqual(presenter.viewModelsFiltered, expectedViewModels)
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_fetchToiletList_whenFilterIsPRM_shouldSuccessWithToiletsWithPRM() {
        // Given
        let expectation = XCTestExpectation(description: "")
        let presenter = ToiletListPresenterImpl(useCase: useCaseMock, appLocation: locationManagerMock)
        presenter.filterStatus = .prm
        useCaseMock.toilets = [
            Toilet(
                address: "Republique",
                openTime: "8 h / 16 h",
                pmrAccess: true,
                geolocalisation: CLLocation(latitude: 48.878670498826594, longitude: 2.3585432997295994),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            ),
            Toilet(
                address: "Opera",
                openTime: "24 h / 24",
                pmrAccess: false,
                geolocalisation: CLLocation(latitude: 48.86112313165573, longitude: 2.3670324237623683),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            )
        ]

        let expectedViewModels = [
            ToiletViewModel(
                address: "Republique",
                openingHour: "8 h / 16 h",
                isPrmFriendly: true,
                distanceFromToilet: 0
            )
        ]

        // When
        presenter.fetchToilets()
        presenter.filter()

        // Then
        presenter.didUpdate = {
            expectation.fulfill()
            if expectation.expectedFulfillmentCount == 2 {
                XCTAssertEqual(presenter.viewModelsFiltered, expectedViewModels)
            }
        }

        wait(for: [expectation], timeout: 10)
    }

    func test_fetchToiletList_whenFilterIsWithoutPRM_shouldSuccessWithToiletsWithPRM() {
        // Given
        let expectation = XCTestExpectation(description: "")
        let presenter = ToiletListPresenterImpl(useCase: useCaseMock, appLocation: locationManagerMock)
        presenter.filterStatus = .prm
        useCaseMock.toilets = [
            Toilet(
                address: "Republique",
                openTime: "8 h / 16 h",
                pmrAccess: true,
                geolocalisation: CLLocation(latitude: 48.878670498826594, longitude: 2.3585432997295994),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            ),
            Toilet(
                address: "Opera",
                openTime: "24 h / 24",
                pmrAccess: false,
                geolocalisation: CLLocation(latitude: 48.86112313165573, longitude: 2.3670324237623683),
                currentPosition: CLLocation(latitude: 400.12345, longitude: 420.12345)
            )
        ]

        let expectedViewModels = [
            ToiletViewModel(
                address: "Opera",
                openingHour: "24 h / 24",
                isPrmFriendly: false,
                distanceFromToilet: 0
            )
        ]

        // When
        presenter.fetchToilets()
        presenter.filter()

        // Then
        presenter.didUpdate = {
            expectation.fulfill()
            if expectation.expectedFulfillmentCount == 2 {
                XCTAssertEqual(presenter.viewModelsFiltered, expectedViewModels)
            }
        }

        wait(for: [expectation], timeout: 10)
    }
}
