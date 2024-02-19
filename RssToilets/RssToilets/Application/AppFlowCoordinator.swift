//
//  AppFlowCoordinator.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppFlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    private var startCoordinator: Coordinator?

    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let toiletsDIContainer = appDIContainer.makeToiletListDIContainer()
        startCoordinator = toiletsDIContainer.makeToiletsCoordinator(navigationController: navigationController)
        startCoordinator?.start()
    }
}
