//
//  YoutubeEntity.swift
//  APIModule
//
//  Created by Jun Morita on 2023/03/28.
//

import Foundation

public struct YoutubeThumbnailBase: Codable {
    public var id: String = UUID().uuidString
    public let _default: YoutubeThumbnail // ここが怒られそう
    public let medium: YoutubeThumbnail
    public let high: YoutubeThumbnail
}

public struct YoutubeThumbnail: Codable {
    public var id: String = UUID().uuidString
    public let url: URL
    public let width: CGFloat
    public let height: CGFloat
}

public struct YoutubeSnippet: Codable {
    // channelTitle, 配信中有無は割愛
    public let channelId: String
    public let publishedAt: Date
    public let title: String
    public let description: String
    public let thumbnails: YoutubeThumbnailBase
}

public struct YoutubeID: Codable {
    public let kind: String
    public let videoId: String
}

public struct YoutubeEntity: Codable {
    public let id: YoutubeID
    public let snuippet: YoutubeSnippet
}
