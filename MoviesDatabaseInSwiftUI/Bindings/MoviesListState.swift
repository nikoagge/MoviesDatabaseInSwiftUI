//
//  MoviesListState.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

final class MoviesListState: ObservableObject {
    @Published var error: NSError?
    @Published var isLoading = false
    @Published var movies: [Movie]?
    
    private let moviesService: MoviesService
    
    init(moviesService: MoviesService = MoviesStore.shared) {
        self.moviesService = moviesService
    }
    
    func fetchMovies(from moviesListEndPoint: MoviesListEndPoints) {
        isLoading = false
        movies = nil
        
        moviesService.fetchMovies(
            from: moviesListEndPoint) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let success):
                    movies = success.movies
                case .failure(let failure):
                    error = failure as NSError
                }
            }
    }
}
