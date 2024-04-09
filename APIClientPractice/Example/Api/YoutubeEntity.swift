//
//  YoutubeEntity.swift
//  APIModule
//
//  Created by Jun Morita on 2023/03/28.
//

import Foundation

struct YoutubeEntity: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
    
    init(kind: String, etag: String, nextPageToken: String, regionCode: String, pageInfo: PageInfo, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.regionCode = regionCode
        self.pageInfo = pageInfo
        self.items = items
    }
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct Item: Codable {
    let kind: String
    let etag: String
    let id: YoutubeID
    let snippet: YoutubeSnippet
}

struct YoutubeID: Codable {
    let kind: String
    let videoId: String
}

struct YoutubeSnippet: Codable {
    // channelTitle, 配信中有無は割愛
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: YoutubeThumbnailBase
    let channelTitle: String
    let liveBroadcastContent: String
    let publishTime: String
}

struct YoutubeThumbnailBase: Codable {
    let _default: YoutubeThumbnail
    let medium: YoutubeThumbnail
    let high: YoutubeThumbnail
    
    enum CodingKeys: String, CodingKey {
        case _default = "default"
        case medium
        case high
    }
}

struct YoutubeThumbnail: Codable {
    let url: String
    let width: Int
    let height: Int
}
