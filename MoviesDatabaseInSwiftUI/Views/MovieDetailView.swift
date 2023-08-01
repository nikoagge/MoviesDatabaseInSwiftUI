//
//  MovieDetailView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 30/7/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movieID: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(
                error: movieDetailState.error,
                isLoading: movieDetailState.isLoading) {
                    movieDetailState.loadMovie(with: movieID)
            }
            
            if let movie = movieDetailState.movie {
                MovieDetailListView(movie: movie)
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            movieDetailState.loadMovie(with: movieID)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieID: Movie.stubbedMovie.id)
        }
    }
}
