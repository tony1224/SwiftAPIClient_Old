//
//  YoutubeRepository.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/08/15.
//

import Foundation

class YoutubeRepository: YoutubeRepositoryProtocol {
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func search(query: String) async throws -> YoutubeEntity {
        try await apiClient.request(api: YoutubeSearchApi(query: query))
    }
}
