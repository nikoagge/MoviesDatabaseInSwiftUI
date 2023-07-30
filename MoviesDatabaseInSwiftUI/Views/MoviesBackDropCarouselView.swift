//
//  MoviesBackDropCarouselView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import SwiftUI

struct MoviesBackDropCarouselView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
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
                        MovieBackDropCardView(movie: movie)
                            .frame(
                                width: 310,
                                height: 200
                            )
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

struct MoviesBackDropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesBackDropCarouselView(
            title: "Latest",
            movies: Movie.stubbedMovies
        )
    }
}
