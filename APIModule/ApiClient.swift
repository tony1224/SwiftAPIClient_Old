//
//  ApiClient.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

public protocol ApiClient {
    // FIXME: operationNotifierはprotobufで必要なだけ
    func request<T: Api>(api: T) async throws -> T.Response
}

public class DefaultApiClient: ApiClient {
    
    public init() {}
    
    public func request<T>(api: T) async throws -> T.Response where T : Api {
        guard let urlRequest = try? createRequest(api) else {
            throw ApiError.Client.parameterParseError
        }
        do {
            let result = try await Task.retrying(maxRetryCount: T.retryWhenNetworkConnectionLost.maxRetry) {
                return try await URLSession.shared.data(for: urlRequest)
            }.value
            guard let urlResponse = result.1 as? HTTPURLResponse, case 200..<400 = urlResponse.statusCode else {
                var errorResponse = try parseErrorResponse(api, data: result.0)
                errorResponse.url = result.1.url
                // FIXME: RでNative側で作成する必要があったError処理
                throw ApiError.Client.parameterParseError
            }
            // FIXME: Rみたくjson or protobufが無い限りはここは不要
            // let contentTypeString = urlResponse.allHeaderFields["Content-Type"] as? String
            // let contentType = contentTypeString.flatMap { ApiResponseContentsType(rawValue: $0) } ?? .json
            return try T.parseResponse(data: result.0)
        } catch {
            // TODO: 通信遮断について
            throw error
        }
    }
    
    private func createRequest<T: Api>(_ api: T) throws -> URLRequest {
        guard let url = api.url else {
            throw ApiError.Client.parameterParseError
        }
        
        var urlRequest: URLRequest
        switch T.method {
        case .get:
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), api.queryItems.count > 0 {
                urlComponents.queryItems = []
                api.queryItems.forEach {
                    urlComponents.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
                }
                urlRequest = URLRequest(url: urlComponents.url!)
            } else {
                urlRequest = URLRequest(url: url)
            }
        case .post:
            urlRequest = URLRequest(url: url)
            urlRequest.httpBody = try api.requestBody()
        }
        
        urlRequest.httpMethod = T.method.rawValue
        
        // FIXME: Youtube Data Apiは多分header対応不要でよさそう
        // GETのみ
        // Youtube Data Apiに関してはsessionToken的なのは
        // APIキーで対応する
        // のでsessionProvider.isSessinTokenRequiredはfalse
        // urlRequest.allHTTPHeaderFields = try createHeaders(api)
        return urlRequest
    }
    
//    private func createHeaders<T: Api>(_ api: T) throws -> [String: String] {
//        let headers = [String: String]()
//
//        return headers
//    }
    
    private func parseErrorResponse<T: Api>(_ api: T, data: Data) throws -> T.ErrorResponse {
        return try JSONDecoder().decode(T.ErrorResponse.self, from: data)
    }
}
