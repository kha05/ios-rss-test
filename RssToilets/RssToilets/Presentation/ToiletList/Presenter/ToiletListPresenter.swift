//
//  ToiletListPresenter.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

typealias ToiletListPresenterCallback = (() -> Void)?

protocol ToiletListPresenter {
    var didUpdate: ToiletListPresenterCallback { get set }
    var viewModelsFiltered: [ToiletViewModel] { get set }
    var filterStatus: FilterStatus { get set }

    func fetchToilets()
    func filter()
}

final class ToiletListPresenterImpl: ToiletListPresenter {
    private let useCase: ToiletListUseCase
    private var appLocation: AppLocation
    private var viewModels: [ToiletViewModel] = []
    
    var viewModelsFiltered: [ToiletViewModel] = []
    var filterStatus = FilterStatus.all

    public var didUpdate: (() -> Void)? = nil

    init(useCase: ToiletListUseCase, appLocation: AppLocation) {
        self.useCase = useCase
        self.appLocation = appLocation
        self.appLocation.delegate = self
    }

    func fetchToilets() {
        Task.init {
            let currentPosition = await appLocation.getUserLocation()
            self.viewModels = await useCase.fetchToilets(from: currentPosition).map({ $0.toViewModel() })
            self.viewModelsFiltered = viewModels
            await MainActor.run {
                didUpdate?()
            }
        }
    }

    func filter() {
        switch filterStatus {
        case .all:
            viewModelsFiltered = viewModels
            filterStatus = .prm
        case .prm:
            viewModelsFiltered = viewModels.filter({ $0.isPrmFriendly })
            filterStatus = .nonPrm
        case .nonPrm:
            viewModelsFiltered = viewModels.filter({ !$0.isPrmFriendly })
            filterStatus = .all
        }
        didUpdate?()
    }
}

extension ToiletListPresenterImpl: AppLocationDelegate {
    func didUpdateLocation() {
        fetchToilets()
    }
}
