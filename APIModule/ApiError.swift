//
//  ApiError.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public enum ApiError: Error {
//    case server(Server)
//    case client(Client)
    case undefined
    
    public enum Client: ApiErrorCategory {
        case parameterParseError
        case jsonParseError(URL?, Error)
        case sessionTokenRequired
        case notConnectedToInternet(URL?)
    }
}

public protocol ApiErrorCategory: Error {}
