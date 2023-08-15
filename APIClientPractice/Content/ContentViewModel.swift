//
//  ContentViewModel.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/03/28.
//

import Foundation

class ContentViewModel: ObservableObject {
    private let useCase: ContentUseCaseProtocol

    init(useCase: ContentUseCaseProtocol) {
        self.useCase = useCase
        Task {
            await fetchYoutube()
        }
    }
    
    @MainActor
    func fetchYoutube() async {
        do {
            let entity = try await useCase.searchMovie(query: "dog")
            print(entity)
        } catch {
            print(error)
        }
    }
    
}
