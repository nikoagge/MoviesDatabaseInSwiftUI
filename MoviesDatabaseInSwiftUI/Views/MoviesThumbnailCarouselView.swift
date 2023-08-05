//
//  MoviesThumbnailCarouselView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

struct MoviesThumbnailCarouselView: View {
    let title: String
    let movies: [Movie]
    var thumbnailType: MovieThumbnailType = .poster()
    
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
                LazyHStack(
                    alignment: .top,
                    spacing: 16
                ) {
                    ForEach(movies) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieID: movie.id)
                        ) {
                            MovieThumbnailView(
                                movie: movie,
                                thumbnailType: thumbnailType
                            )
                            .movieThumbnailViewFrame(thumbnailType: thumbnailType)
                        }
                        .buttonStyle(PlainButtonStyle())
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
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}

fileprivate extension View {
    @ViewBuilder
    func movieThumbnailViewFrame(thumbnailType: MovieThumbnailType) -> some View {
        switch thumbnailType {
        case .backdrop:
            self
                .aspectRatio(
                    16/9,
                    contentMode: .fit
                )
                .frame(
                    height: 160
                )
            
        case .poster:
            self
                .frame(
                    width: 204,
                    height: 310
                )
        }
    }
}

struct MoviesPosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviesThumbnailCarouselView(
                title: "Now Playing",
                movies: Movie.stubbedMovies,
                thumbnailType: .poster(showTitle: true)
            )
            
            MoviesThumbnailCarouselView(
                title: "Upcoming",
                movies: Movie.stubbedMovies,
                thumbnailType: .poster(showTitle: true)
            )
        }
    }
}
