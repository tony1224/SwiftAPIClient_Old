//
//  API.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public enum ApiHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum ApiRetryStrategy {
    case none
    case retry(maxRetry: Int)
    
    public static func retryWhenNetworkConnectionLostDefault() -> ApiRetryStrategy {
        return .retry(maxRetry: 3)
    }
    
    public var maxRetry: Int {
        switch self {
        case .none:
            return 0
        case .retry(let maxRetry):
            return maxRetry
        }
    }
}

public protocol Api {
    associatedtype RequestParams
    associatedtype Response
    associatedtype ErrorResponse: ApiErrorResponse
    
    static var baseUrl: String { get }
    static var path: String { get }
    static var method: ApiHTTPMethod { get }
    static var retryWhenNetworkConnectionLost: ApiRetryStrategy { get }
    // RみたくresponseTypeがある場合はtype: ApiResponseContentsTypeを追加
    static func parseResponse(data: Data) throws -> Response
    
    var requestParams: RequestParams { get }
    var queryItems: [String: String] { get }
    // 不要では？
//    var sessionProvider: ApiSessionProvider { get }
    
    var url: URL? { get }
    func requestBody() throws -> Data
}

//public protocol ApiSessionProvider {
//    var isSessionTokenRequired: Bool { get }
//    // RだとsessionTokenを保持するタイプが分かれるためsessionTokenを取得する
//    // 関数をここで用意
//}

//public enum ApiRequestContentsType: String {
//    case json = "application/json"
//    // Rだとapplication/x-protobufもある
//}

//public enum ApiResponseContentsType: String {
//    case json = "application/json"
//    // Rだとapplication/x-protobufもある
//}

//public enum ApiAcceptType: String {
//    case json = "application/json"
//    // Rだとapplication/x-protobufもある
//}
