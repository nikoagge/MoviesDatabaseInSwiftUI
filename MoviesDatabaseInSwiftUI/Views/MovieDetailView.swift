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

struct MovieDetailListView: View {
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: movie.backgroundURL)
                .listRowInsets(EdgeInsets())
        }
    }
}

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
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
