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

    func search(query: String) async throws -> [YoutubeDomainEntity] {
        let res = try await apiClient.request(api: YoutubeSearchApi(query: query))
        return res.items.map {
            YoutubeDomainEntity(videoId: $0.id.videoId, snippetTitle: $0.snippet.title)
        }
    }
}
