//
//  GithubDataApi.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/30.
//

import Foundation

public protocol YoutubeApi: Api {}

public extension YoutubeApi {
    static var baseUrl: String {
        return "https://www.googleapis.com/youtube/v3"
    }
}

public struct YoutubeApiResponse<T> {
    
}
