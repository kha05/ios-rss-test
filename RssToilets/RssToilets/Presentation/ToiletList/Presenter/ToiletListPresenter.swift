//
//  ToiletListPresenter.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletListPresenter {
    var didUpdate: (() -> Void)? { get set }
    var viewModelsFiltered: [ToiletViewModel] { get set }
    var filterStatus: FilterStatus { get set }

    func fetchToilets()
    func filter()
}

final class ToiletListPresenterImpl: ToiletListPresenter {
    private let useCase: ToiletListUseCase
    private var viewModels: [ToiletViewModel] = []
    
    var viewModelsFiltered: [ToiletViewModel] = []
    var filterStatus = FilterStatus.all

    public var didUpdate: (() -> Void)? = nil

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToilets() {
        Task.init {
            self.viewModels = await useCase.fetchToilets().map({ $0.toViewModel(with: nil) })
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
