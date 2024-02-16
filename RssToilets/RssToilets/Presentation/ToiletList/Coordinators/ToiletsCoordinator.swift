//
//  ToiletsCoordinator.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import UIKit

protocol ToiletsCoordinatorDependencies  {
    func makeToiletListViewController() -> ToiletListViewController
}

protocol ToiletsCoordinator {
    func start()
}

final class ToiletsCoordinatorImpl: ToiletsCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: ToiletsCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: ToiletsCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.makeToiletListViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}

