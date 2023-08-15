//
//  GithubDataApi.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/30.
//

import Foundation

let youtubeApiKey = "AIzaSyCzenyv3g_tPZdebAOKLZA2tA75wrbPIRU"

public protocol YoutubeApi: RequestProtocol {}

public extension YoutubeApi {
    var baseURL: String {
        return "https://www.googleapis.com/youtube/v3"
    }
}

public struct YoutubeSearchApi: YoutubeApi {    
    public typealias Response = YoutubeEntity
    // postの話だったのでここではなし
//    public struct RequestParams: Codable {
//        let key: String
//        let q: String
//        let type: String
//        let part: String
//    }
    public var path: String = "search"
    public var method: HTTPMethod = .get
    public var parameters: [String : Any]?
//    public let requestParams: YoutubeSearchApi.RequestParams
    
    init(query: String) {
//        requestParams = .init(key: youtubeApiKey, q: query, type: "video", part: "snippet")
        parameters = [
            "key": youtubeApiKey,
            "q": query,
            "type": "video",
            "part": "snippet"
        ]
    }
}
