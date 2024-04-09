//
//  ApiError.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public enum ApiError: Error {
    case url(URL)
    case network
    case response
    case emptyResponse
    case parse(URL?, Error)
    case undefined(status: Int, data: Data)
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .url:
            return "URLが無効"
        case .network:
            return "ネットワーク未接続"
        case .response:
            return "レスポンス取得失敗"
        case .emptyResponse:
            return "レスポンスが空"
        case .parse:
            return "パースエラー"
        case .undefined(status: let status, data: let data):
            return "エラー statusCode: \(status), data: \(data)"
        }
    }
}
