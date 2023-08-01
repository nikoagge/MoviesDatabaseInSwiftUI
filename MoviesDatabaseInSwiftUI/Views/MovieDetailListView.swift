//
//  MovieDetailListView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 31/7/23.
//

import SwiftUI

struct MovieDetailListView: View {
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: movie.backgroundURL)
                .listRowInsets(EdgeInsets())
            
            HStack {
                Text(movie.genreText)
                Text("⚫️")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText)
                        .foregroundColor(.yellow)
                }
                
                Text(movie.scoreText)
            }
            
            Divider()
        }
    }
}

struct MovieDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailListView(movie: Movie.stubbedMovie)
    }
}
