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
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    
    static private let yearFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = .full
        dateComponentsFormatter.allowedUnits = [.hour, .minute]
        
        return dateComponentsFormatter
    }()
    
    var backgroundURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        
        return ratingText
    }
    
    var scoreText: String {
        guard !ratingText.isEmpty else { return "n/a" }
        
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = releaseDate,
                let date = Utilities.dateFormatter.date(from: releaseDate) else { return "n/a"}
        
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = runtime,
              runtime > 0 else { return "n/a" }
        
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
}

struct MovieGenre: Codable {
    let name: String
}
