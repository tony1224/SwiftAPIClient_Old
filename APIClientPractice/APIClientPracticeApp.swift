//
//  APIClientPracticeApp.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/01/25.
//

import SwiftUI

@main
struct APIClientPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentStore(repository: YoutubeRepository(apiClient: ApiClient())))
        }
    }
}
