//
//  Movies.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 15/7/23.
//

import Foundation

struct Movies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    
    var backgroundURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
