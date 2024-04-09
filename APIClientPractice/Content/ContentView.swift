//
//  ContentView.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowAlert: Bool = false
    @State private var errorMessage: String = ""
    @EnvironmentObject var contentStore: ContentStore
    
    var items: [YoutubeDomainEntity] {
        contentStore.values
    }
    
    func load() async {
        do {
            try await contentStore.searchValues(by: "test")
        } catch {
            shouldShowAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    var body: some View {
        Form {
            ForEach(items, id: \.videoId) { item in
                Text(item.snippetTitle)
            }
        }
        .task {
            await load()
        }
        .alert("Error", isPresented: $shouldShowAlert, actions: {}, message: {
            Text(errorMessage)
        })
        
    }
}


// NOTE: このリポジトリではここを頑張っても仕方ない
// きちんと実行しRepository, APIを通して正しい値を取得できること
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentStore(repository: PreviewYoutubeRepository()))
    }
}

private struct PreviewYoutubeRepository: YoutubeRepositoryProtocol {
    func search(query: String) async throws -> [YoutubeDomainEntity] {
        [
            .init(videoId: "1", snippetTitle: "TestA"),
            .init(videoId: "2", snippetTitle: "TestB"),
            .init(videoId: "3", snippetTitle: "TestC"),
        ]
    }
}

