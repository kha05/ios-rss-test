//
//  ToiletListPresenter.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

protocol ToiletListPresenter {
    func fetchToilets()
}

final class ToiletListPresenterImpl: ToiletListPresenter, ObservableObject {
    private let useCase: ToiletListUseCase
    @Published private var viewModels: [ToiletViewModel] = []

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToilets() {
        Task.init {
            self.viewModels = await useCase.fetchToilets().map({ $0.toViewModel(with: nil) })
        }
    }
}
