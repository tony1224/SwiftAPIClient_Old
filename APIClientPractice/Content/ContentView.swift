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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let uc = ContentUseCase(repository: YoutubeRepository())
        return ContentView(useCase: uc)
    }
}
