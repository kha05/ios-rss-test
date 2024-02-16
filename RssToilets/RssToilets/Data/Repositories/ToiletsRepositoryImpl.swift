//
//  ToiletsRepository.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

final class ToiletsRepositoryImpl {

    private let remoteSource: NetworkService

    init(remoteSource: NetworkService) {
        self.remoteSource = remoteSource
    }
}

extension ToiletsRepositoryImpl: ToiletsRepository {
    func fetchToilets(start: Int, rows: Int) async -> [RemoteToilet] {
        let request = RemoteToiletsRequest(start: start, rows: rows)
        do {
            let response: Result<RemoteToilets?, Error> = try await remoteSource.execute(endpoint: APIEndpoints.getToilets(with: request))
            switch response {
            case let .success(remoteData):
                return remoteData?.records.compactMap({ $0.fields }) ?? []
            case .failure(let failure):
                print(NetworkError.servorError)
            }
        } catch {
            print(NetworkError.servorError)
        }
        return []
    }
}
