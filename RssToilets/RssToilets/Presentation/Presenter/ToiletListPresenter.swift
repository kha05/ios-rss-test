//
//  ToiletListPresenter.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletListPresenter {
    var didUpdate: (([ToiletViewModel]) -> Void)? { get set }

    func fetchToilets()
}

final class ToiletListPresenterImpl: ToiletListPresenter {
    private let useCase: ToiletListUseCase
    private var viewModels: [ToiletViewModel] = []
   
    public var didUpdate: (([ToiletViewModel]) -> Void)? = nil

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToilets() {
        Task.init {
            self.viewModels = await useCase.fetchToilets().map({ $0.toViewModel(with: nil) })
            didUpdate?(viewModels)
        }
    }
}
