//
//  ToiletListPresenter.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletListPresenter {
    var didUpdate: (() -> Void)? { get set }
    var viewModels: [ToiletViewModel] { get }

    func fetchToilets()
}

final class ToiletListPresenterImpl: ToiletListPresenter {
    private let useCase: ToiletListUseCase
    var viewModels: [ToiletViewModel] = []

    public var didUpdate: (() -> Void)? = nil

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToilets() {
        Task.init {
            self.viewModels = await useCase.fetchToilets().map({ $0.toViewModel(with: nil) })
            await MainActor.run {
                didUpdate?()
            }
        }
    }
}
