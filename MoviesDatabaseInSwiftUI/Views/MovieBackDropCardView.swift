//
//  MovieBackDropCardView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import SwiftUI

struct MovieBackDropCardView: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(.gray.opacity(0.3))
                
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                }
            }
            .aspectRatio(
                16/9,
                contentMode: .fit
            )
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
        }
        .onAppear {
            imageLoader.loadImage(with: movie.backgroundURL)
        }
    }
}

struct MovieBackDropCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackDropCardView(movie: Movie.stubbedMovie)
    }
}
