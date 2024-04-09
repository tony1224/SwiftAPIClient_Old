//
//  GithubDataApi.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/30.
//

import Foundation

let youtubeApiKey = "AIzaSyCzenyv3g_tPZdebAOKLZA2tA75wrbPIRU"

public protocol YoutubeApi: ApiRequestProtocol {}

public extension YoutubeApi {
    var baseURL: URL {
        URL(string: "https://www.googleapis.com/youtube/v3")!
    }
    // YoutubeAPIでは不要
    var header: HttpHeader? {
        nil
    }
}

public struct YoutubeSearchApi: YoutubeApi {
    public typealias Response = YoutubeEntity
    public var path: String = "search"
    public var method: HTTPMethod = .get
    public var httpBody: Encodable?
    public var parameters: [String : String]?
    
    init(query: String) {
        parameters = [
            "key": youtubeApiKey,
            "q": query,
            "type": "video",
            "part": "snippet"
        ]
    }
}
