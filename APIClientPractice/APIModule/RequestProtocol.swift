//
//  RequestProtocol.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public protocol RequestProtocol {
    associatedtype Response
    var method: HTTPMethod { get }
    // 各APIでこのI/F準拠の元extensionを作りここを指定
    var baseURL: String { get }
    var path: String { get }

    // dictよりもstruct定義の方が書きやすい
    var parameters: [String: Any]? { get set }
    // TODO: postで出てくる
    // associatedtype RequestParams
    // var requestParams: RequestParams { get }
    // func requestBody() throws -> Data

    // associatedtype ErrorResponse: ApiErrorResponse
    
    // retryの仕組みは一旦保留
    // static var retryWhenNetworkConnectionLost: ApiRetryStrategy { get }

    // RみたくresponseTypeがある場合はtype: ApiResponseContentsTypeを追加
    static func parseResponse(data: Data) throws -> Response
    
    // YoutubeDataApiでsessionToken的なのはAPIキーで対応する
    // のでsessionProvider.isSessinTokenRequiredはfalse
    // var sessionProvider: ApiSessionProvider { get }    
}

public extension RequestProtocol where Response: Swift.Decodable {
    static func parseResponse(data: Data) throws -> Response {
        try JSONDecoder().decode(Response.self, from: data)
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//public enum ApiRetryStrategy {
//    case none
//    case retry(maxRetry: Int)
//
//    public static func retryWhenNetworkConnectionLostDefault() -> ApiRetryStrategy {
//        return .retry(maxRetry: 3)
//    }
//
//    public var maxRetry: Int {
//        switch self {
//        case .none:
//            return 0
//        case .retry(let maxRetry):
//            return maxRetry
//        }
//    }
//}

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
