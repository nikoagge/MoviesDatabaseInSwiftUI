//
//  Movie+Extension.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import Foundation

extension Movie {
    static var stubbedMovies: [Movie] {
        let response: Movies? = try? Bundle.main.loadBundleAndDecodedData(fileName: "movie_list")
        
        return response?.movies ?? []
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
}
