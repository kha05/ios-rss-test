//
//  AppFlowCoordinator.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let toiletsDIContainer = appDIContainer.makeToiletListDIContainer()
        let flow = toiletsDIContainer.makeToiletsCoordinator(navigationController: navigationController)
        flow.start()
    }
}
