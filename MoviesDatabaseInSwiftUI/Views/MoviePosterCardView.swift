//
//  MoviePosterCardView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import SwiftUI

struct MoviePosterCardView: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.4))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(
            width: 220,
            height: 310
        )
        .onAppear {
            imageLoader.loadImage(with: movie.posterURL)
        }
    }
}

struct MoviePosterCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCardView(movie: Movie.stubbedMovie)
    }
}
