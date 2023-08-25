//
//  ContentViewModel.swift
//  APIClientPractice
//
//  Created by Jun Morita on 2023/03/28.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var shouldShowAlert: Bool = false
    @Published private(set) var errorMessage: String = ""
    private let useCase: ContentUseCaseProtocol

    init(useCase: ContentUseCaseProtocol) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchYoutube() async {
        do {
            let entity = try await useCase.searchMovie(query: "dog")
            print(entity)
        } catch {
            shouldShowAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
}
