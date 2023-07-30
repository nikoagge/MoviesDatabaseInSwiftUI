//
//  MoviesPosterCarouselView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

struct MoviesPosterCarouselView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                HStack(
                    alignment: .top,
                    spacing: 16
                ) {
                    ForEach(movies) { movie in
                        MoviePosterCardView(movie: movie)
                            .padding(
                                .leading,
                                movie.id == movies.first!.id ? 16 : 0
                            )
                            .padding(
                                .trailing,
                                movie.id == movies.last!.id ? 16 : 0
                            )
                    }
                }
            }
        }
    }
}

struct MoviesPosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesPosterCarouselView(
            title: "Now Playing",
            movies: Movie.stubbedMovies
        )
    }
}
