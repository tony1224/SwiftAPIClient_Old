//
//  ContentStore.swift
//  APIClientPractice
//
//  Created by admin on 2024/04/03.
//

import Foundation
import Combine

@MainActor
final class ContentStore: ObservableObject {
    @Published private(set) var values: [YoutubeDomainEntity] = []
    
    private let repository: any YoutubeRepositoryProtocol
    
    init(repository: any YoutubeRepositoryProtocol) {
        self.repository = repository
    }
    
//    func loadValue(for id: User.ID) async throws {
//        if let value = try await repository.fetchValue(for: id) {
//            values[value.id] = value
//        } else {
//            // SV側でUserが消えている=>自身の状態からも消す
//            values.removeValue(forKey: id)
//        }
//    }

    func searchValues(by query: String) async throws {
        values = try await repository.search(query: query)
    }

}
