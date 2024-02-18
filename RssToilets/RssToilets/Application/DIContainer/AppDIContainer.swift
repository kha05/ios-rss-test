//
//  AppDIContainer.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var networkService: NetworkService = {
        let url = URL(string: appConfiguration.apiBaseURL)
        let config = ApiDataNetworkConfig(baseURL: url)
        return NetworkServiceImpl(config: config)
    }()

    // MARK: - AppLocation
    lazy var appLocation: AppLocation = {
        AppLocationImpl()
    }()

    // MARK: - DIContainers
    func makeToiletListDIContainer() -> ToiletsDIContainer {
        ToiletsDIContainer(dependencies: .init(networkService: networkService, appLocation: appLocation))
    }
}
