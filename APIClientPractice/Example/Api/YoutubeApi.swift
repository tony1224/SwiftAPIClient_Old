//
//  GithubDataApi.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/30.
//

import Foundation

let youtubeApiKey = "AIzaSyCzenyv3g_tPZdebAOKLZA2tA75wrbPIRU"

protocol YoutubeApi: ApiRequestProtocol {}

extension YoutubeApi {
    var baseURL: URL {
        URL(string: "https://www.googleapis.com/youtube/v3")!
    }
    // YoutubeAPIでは不要
    var header: HttpHeader? {
        nil
    }
}

struct YoutubeSearchApi: YoutubeApi {
    typealias Response = YoutubeEntity
    var path: String = "search"
    var method: HTTPMethod = .get
    var httpBody: Encodable?
    var parameters: [String : String]?
    
    init(query: String) {
        parameters = [
            "key": youtubeApiKey,
            "q": query,
            "type": "video",
            "part": "snippet"
        ]
    }
}
