//
//  ContentUseCaseProtocol.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/08/15.
//

import Foundation

protocol ContentUseCaseProtocol {
    func searchMovie(query: String) async throws -> YoutubeEntity
}

class ContentUseCase: ContentUseCaseProtocol {
    private let repository: YoutubeRepositoryProtocol
    
    init(repository: YoutubeRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchMovie(query: String) async throws -> YoutubeEntity {
        try await repository.search(query: query)
    }
    
}
