//
//  ApiError.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public protocol ApiErrorResponsePayload: Codable {
    var message: String { get }
    var detailedError: String { get }
    var errorCode: UInt32 { get }
}

public protocol ApiErrorResponse: Codable {
    associatedtype Payload: ApiErrorResponsePayload
    var payload: Payload { get }
    var url: URL? { get set }
}

//public extension ApiErrorResponse {
//    func makeVliveError() -> ApiError {
//        return errorWithPayload(payload: payload, url: url)
//    }
//}

// ErrorResponsePayloadTypeの定義はServer側に依存
//public func errorWithPayload(payload: ErrorResponsePayloadType, url: URL? = nil) -> ApiError {
//    let code = (UInt32(payload.errorCode) & 0xF0000000) >> 28
//
//    switch code {
//    case 1, 2, 3, 4:
//        return makeServerError(payload: payload, url: url)
//    case 5:
//        return VliveError.auth(.common(payload))
//    case 6:
//        return makeLimitedAccessError(payload: payload)
//    case 7:
//        return makeUpdateRequestError(payload: payload)
//    case 8:
//        return VliveError.serviceUnavailable(.common(payload))
//    default:
//        return VliveError.undefined
//    }
//}

public enum ApiError: Error {
//    case server(Server)
//    case client(Client)
    case undefined
    
    public enum Client: ApiErrorCategory {
        case failedToCreateURL
        case failedToCreateComponents(URL)
        case noResponse
        case unacceptableStatusCode(Int)
        
        case parameterParseError
        case jsonParseError(URL?, Error)
        case sessionTokenRequired
        case notConnectedToInternet(URL?)
    }
}

public protocol ApiErrorCategory: Error {}
