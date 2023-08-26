//
//  ContentView.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    
    init(useCase: ContentUseCaseProtocol) {
        _viewModel = StateObject(wrappedValue: ContentViewModel(useCase: useCase))
    }
    
    var body: some View {
        Form {
            ForEach(viewModel.itemList, id: \.id.videoId) { item in
                Text(item.snippet.title)
            }
        }
        .task {
            await viewModel.fetchYoutube()
        }
        .alert("Error", isPresented: $viewModel.shouldShowAlert, actions: {}, message: {
            Text(viewModel.errorMessage)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let uc = ContentUseCase(repository: YoutubeRepository(apiClient: ApiClient()))
        return ContentView(useCase: uc)
    }
}
