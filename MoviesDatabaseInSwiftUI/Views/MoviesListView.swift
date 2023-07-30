//
//  MoviesListView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject private var nowPlayingState = MoviesListState()
    @ObservedObject private var popularState = MoviesListState()
    @ObservedObject private var topRatedState = MoviesListState()
    @ObservedObject private var upcomingState = MoviesListState()

    var body: some View {
        NavigationView {
            List {
                Group {
                    if let nowPlayingMovies = nowPlayingState.movies {
                        MoviesPosterCarouselView(
                            title: "Now Playing",
                            movies: nowPlayingMovies
                        )
                    } else {
                        LoadingView(
                            error: nowPlayingState.error, isLoading: nowPlayingState.isLoading
                        ) {
                                nowPlayingState.fetchMovies(from: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(
                    top: 16,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                ))
                .listRowSeparator(.hidden)
                
                Group {
                    if let popularMovies = popularState.movies {
                        MoviesPosterCarouselView(
                            title: "Popular",
                            movies: popularMovies
                        )
                    } else {
                        LoadingView(
                            error: popularState.error, isLoading: popularState.isLoading
                        ) {
                            popularState.fetchMovies(from: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(
                    top: 8,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                ))
                .listRowSeparator(.hidden)
                
                Group {
                    if let topRatedMovies = topRatedState.movies {
                        MoviesPosterCarouselView(
                            title: "Top Rated",
                            movies: topRatedMovies
                        )
                    } else {
                        LoadingView(
                            error: topRatedState.error, isLoading: topRatedState.isLoading
                        ) {
                            topRatedState.fetchMovies(from: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(
                    top: 8,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                ))
                .listRowSeparator(.hidden)
                
                Group {
                    if let upcomingMovies = upcomingState.movies {
                        MoviesPosterCarouselView(
                            title: "Upcoming",
                            movies: upcomingMovies
                        )
                    } else {
                        LoadingView(
                            error: upcomingState.error, isLoading: upcomingState.isLoading
                        ) {
                            upcomingState.fetchMovies(from: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(
                    top: 8,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                ))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("The Movie DB")
        }
        .onAppear {
            nowPlayingState.fetchMovies(from: .nowPlaying)
            popularState.fetchMovies(from: .popular)
            topRatedState.fetchMovies(from: .topRated)
            upcomingState.fetchMovies(from: .upcoming)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
