//
//  MovieDetailListView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 31/7/23.
//

import SwiftUI

struct MovieDetailListView: View {
    @State private var selectedTrailer: MovieVideo?
    
    private let imageLoader = ImageLoader()
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(
                imageLoader: imageLoader,
                imageURL: movie.backgroundURL
            )
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
            
            HStack(
                alignment: .top,
                spacing: 4
            ) {
                if movie.cast != nil && movie.cast!.count > 0 {
                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {
                        Text("Starring")
                            .font(.headline)
                        ForEach(movie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    
                    Spacer()
                }
                
                if let crew = movie.crew, !crew.isEmpty {
                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {
                        if let directors = movie.directors, !directors.isEmpty {
                            Text("Director(s)")
                            ForEach(directors.prefix(2)) { crew in
                                Text(crew.name)
                                    .padding()
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)")
                            ForEach(movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                                    .padding()
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screenwriter(s)")
                            ForEach(movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                            }
                        }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                }
            }
            
            Divider()
            
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers")
                    .font(.headline)
                
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button {
                        selectedTrailer = trailer
                    } label: {
                        HStack {
                            Text(trailer.name)
                            
                            Spacer()
                            
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: $selectedTrailer) { trailer in
            if let youtubeURL = trailer.youtubeURL {
                SafariView(url: youtubeURL)
            }
        }
    }
}

struct MovieDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailListView(movie: Movie.stubbedMovie)
    }
}
