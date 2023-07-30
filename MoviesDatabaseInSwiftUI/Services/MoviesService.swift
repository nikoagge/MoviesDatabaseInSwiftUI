//
//  MoviesService.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 15/7/23.
//

import Foundation

protocol MoviesService {
    func fetchMovies(
        from moviesListEndPoint: MoviesListEndPoints,
        onCompletion: @escaping (Result<Movies, MoviesError>) -> ()
    )
    
    func fetchMovie(
        for id: Int,
        onCompletion: @escaping (Result<Movie, MoviesError>) -> ()
    )
    
    func searchForMovies(
        basedOn query: String,
        onCompletion: @escaping (Result<Movies, MoviesError>) -> ()
    )
}

enum MoviesListEndPoints: String, CaseIterable {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case popular
    case upcoming
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
        case .upcoming: return "Upcoming"
        }
    }
}

enum MoviesError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizeDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizeDescription]
    }
}
