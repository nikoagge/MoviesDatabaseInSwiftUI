//
//  MovieDetailState.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 30/7/23.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    private let movieService: MoviesService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(
        movieService: MoviesService = MoviesStore.shared
    ) {
        self.movieService = movieService
    }
    
    func loadMovie(with id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieService.fetchMovie(for: id) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
