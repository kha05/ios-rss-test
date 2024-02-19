//
//  ToiletsCoordinator.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import UIKit

protocol ToiletsCoordinatorDependencies  {
    func makeToiletListViewController() -> ToiletListViewController
    func makeToiletDetailsViewController(toilet: ToiletViewModel) -> UIViewController
}

protocol ToiletsCoordinatorDelegate: AnyObject {
    func showToiletDetails(toilet: ToiletViewModel)
}

final class ToiletsCoordinatorImpl: Coordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: ToiletsCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: ToiletsCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let viewController = dependencies.makeToiletListViewController()
        viewController.bind(coordinator: self)
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension ToiletsCoordinatorImpl: ToiletsCoordinatorDelegate {
    func showToiletDetails(toilet: ToiletViewModel) {
        let viewController = dependencies.makeToiletDetailsViewController(toilet: toilet)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
