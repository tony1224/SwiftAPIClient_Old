//
//  YoutubeRepositoryProtocol.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/08/15.
//

import Foundation

protocol YoutubeRepositoryProtocol {
    func search(query: String) async throws -> [YoutubeDomainEntity]
}
