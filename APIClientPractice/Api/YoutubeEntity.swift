//
//  YoutubeEntity.swift
//  APIModule
//
//  Created by Jun Morita on 2023/03/28.
//

import Foundation

public struct YoutubeEntity: Codable {
    public let kind: String
    public let etag: String
    public let nextPageToken: String
    public let regionCode: String
    public let pageInfo: PageInfo
    public let items: [Item]
}

public struct PageInfo: Codable {
    public let totalResults: Int
    public let resultsPerPage: Int
}

public struct Item: Codable {
    public let kind: String
    public let etag: String
    public let id: YoutubeID
    public let snippet: YoutubeSnippet
}

public struct YoutubeID: Codable {
    public let kind: String
    public let videoId: String
}

public struct YoutubeSnippet: Codable {
    // channelTitle, 配信中有無は割愛
    public let publishedAt: String
    public let channelId: String
    public let title: String
    public let description: String
    public let thumbnails: YoutubeThumbnailBase
    public let channelTitle: String
    public let liveBroadcastContent: String
    public let publishTime: String
}

public struct YoutubeThumbnailBase: Codable {
    public let _default: YoutubeThumbnail
    public let medium: YoutubeThumbnail
    public let high: YoutubeThumbnail
    
    enum CodingKeys: String, CodingKey {
        case _default = "default"
        case medium
        case high
    }
}

public struct YoutubeThumbnail: Codable {
    public let url: String
    public let width: Int
    public let height: Int
}
