//
//  ApiClient.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public protocol ApiClientProtocol {
    func request<T: ApiRequestProtocol>(api: T) async throws -> T.Response
}

public final class ApiClient: ApiClientProtocol {
    public init() {}
    
    public func request<T: ApiRequestProtocol>(api: T) async throws -> T.Response where T: ApiRequestProtocol {
        guard let urlRequest = try? createURLRequest(api) else {
            throw ApiError.url(api.baseURL.appendingPathComponent(api.path))
        }
        do {
            // TODO: retry
            // let result = try await Task.retrying(maxRetryCount: T.retryWhenNetworkConnectionLost.maxRetry) {
            // return try await URLSession.shared.data(for: urlRequest)
            // }.value
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            // check response
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw ApiError.emptyResponse
            }
            // check status code
            guard 200..<300 ~= urlResponse.statusCode else {
                throw ApiError.undefined(status: urlResponse.statusCode, data: data)
            }
            // FIXME: 一旦JSONだけ想定
            return try JSONDecoder().decode(T.Response.self, from: data)
        } catch {
            throw ApiError.network
        }
    }
    
    private func createURLRequest<T: ApiRequestProtocol>(_ api: T) throws -> URLRequest {
        let url = api.baseURL.appendingPathComponent(api.path)
        var urlRequest: URLRequest
        
        switch api.method {
        case .get:
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw ApiError.url(url)
            }
            components.queryItems = api.parameters?.compactMap {
                .init(name: $0.key, value: "\($0.value)")
            }
            guard let tmpRequest = components.url.map({ URLRequest(url: $0)} ) else {
                throw ApiError.url(url)
            }
            urlRequest = tmpRequest
        case .post:
            urlRequest = URLRequest(url: url)
            if let httpBody = api.httpBody,
               let bodyData = try? JSONEncoder().encode(httpBody) {
                urlRequest.httpBody = bodyData
            }
        }
        urlRequest.httpMethod = api.method.rawValue
        
        // HTTP Header
        if let header = api.header {
            urlRequest.allHTTPHeaderFields = header.values()
        }

        return urlRequest
    }
    
}
