//
//  YoutubeRepository.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/08/15.
//

import Foundation

class ContentRepository: YoutubeRepositoryProtocol {

    func findYoutube() async throws -> YoutubeEntity {
        // TODO: API結合
        .init(id: .init(kind: "string", videoId: "string"), snuippet: .init(channelId: "string", publishedAt: Date(), title: "string", description: "string", thumbnails: .init(_default: .init(url: URL(string: "string")!, width: 100, height: 100), medium: .init(url: URL(string: "string")!, width: 100, height: 100), high: .init(url: URL(string: "string")!, width: 100, height: 100))))
    }
}
