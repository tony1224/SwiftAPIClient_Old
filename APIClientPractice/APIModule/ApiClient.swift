//
//  ApiClient.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public protocol ApiClientProtocol {
    func request<T: RequestProtocol>(api: T) async throws -> T.Response
}

public final class ApiClient: ApiClientProtocol {
    public init() {}
    
    public func request<T: RequestProtocol>(api: T) async throws -> T.Response {
        guard let urlRequest = try? createURLRequest(api) else {
            throw ApiError.Client.parameterParseError
        }
        do {
            // retry処理
            // let result = try await Task.retrying(maxRetryCount: T.retryWhenNetworkConnectionLost.maxRetry) {
            // return try await URLSession.shared.data(for: urlRequest)
            // }.value
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            // responseチェック
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw ApiError.Client.noResponse
            }
            // statuscodeチェック
            guard 200..<300 ~= urlResponse.statusCode else {
                throw ApiError.Client.unacceptableStatusCode(urlResponse.statusCode)
            }
            // 一旦JSONだけ想定
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            // TODO: 通信遮断について
            throw error
        }
    }
    
    private func createURLRequest<T: RequestProtocol>(_ request: T) throws -> URLRequest {
        guard let url = URL(string: request.baseURL)?.appendingPathComponent(request.path) else {
            throw ApiError.Client.failedToCreateURL
        }
        var urlRequest: URLRequest
        switch request.method {
        case .get:
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw ApiError.Client.failedToCreateComponents(url)
            }
            components.queryItems = request.parameters?.compactMap {
                .init(name: $0.key, value: "\($0.value)")
            }
            guard let tmpRequest = components.url.map({ URLRequest(url: $0)} ) else {
                throw ApiError.Client.failedToCreateURL
            }
            urlRequest = tmpRequest
        case .post:
            urlRequest = URLRequest(url: url)
            // TODO: postなAPI対応時に
            // urlRequest.httpBody = try api.requestBody()
        }
        urlRequest.httpMethod = request.method.rawValue

        // NOTE: YoutubeDataApiはheader対応不要
        // urlRequest.allHTTPHeaderFields = try createHeaders(api)
        return urlRequest
    }
    
    // private func createHeaders<T: Api>(_ api: T) throws -> [String: String] {
    //    let headers = [String: String]()
    //    return headers
    // }
    
}
