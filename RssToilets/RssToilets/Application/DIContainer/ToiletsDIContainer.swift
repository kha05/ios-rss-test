//
//  ToiletListDIContainer.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation
import UIKit

final class ToiletsDIContainer: ToiletsCoordinatorDependencies {

    struct Dependencies {
        let networkService: NetworkService
        let appLocation: AppLocation
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Use Cases
    func makeToiletListUseCase() -> ToiletListUseCase {
        ToiletListUseCaseImpl(repository: makeToiletsRepository())
    }

    // MARK: - Presenters
    func makeToiletListPresenter() -> ToiletListPresenter {
        ToiletListPresenterImpl(useCase: makeToiletListUseCase(), appLocation: dependencies.appLocation)
    }

    // MARK: - Repositories
    func makeToiletsRepository() -> ToiletsRepository {
        ToiletsRepositoryImpl(remoteSource: dependencies.networkService)
    }

    // MARK: - Toilet List
    func makeToiletListViewController() -> ToiletListViewController {
        ToiletListViewController(presenter: makeToiletListPresenter())
    }

    // MARK: - Coordinators
    func makeToiletsCoordinator(navigationController: UINavigationController) -> ToiletsCoordinator {
        ToiletsCoordinatorImpl(navigationController: navigationController, dependencies: self)
    }
}
