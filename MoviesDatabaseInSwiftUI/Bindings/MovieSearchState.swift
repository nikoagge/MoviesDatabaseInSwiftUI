//
//  MovieSearchState.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 3/8/23.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class MovieSearchState: ObservableObject {
    @Published private(set) var phrase: DataFetchPhrase
    @Published var query = ""
    
    private var subscriptionToken: AnyCancellable?
    
    let movieService: MoviesService
    
    init(movieService: MoviesService = MoviesStore.shared) {
        self.movieService = movieService
    }
    
    func startToObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                guard let self = self else { return }
                self.error = nil
                self.movies = nil
                
                return text
            }.throttle(
                for: 1,
                scheduler: DispatchQueue.main,
                latest: true
            )
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.search(query: $0)
                }
    }
    
    func search(query: String) {
        error = nil
        isLoading = false
        movies = nil
        
        guard !query.isEmpty else { return }
        
    }
}
