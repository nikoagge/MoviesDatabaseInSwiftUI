//
//  MovieThumbnailView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import SwiftUI

enum MovieThumbnailType {
    case backdrop
    case poster(showTitle: Bool = true)
}

struct MovieThumbnailView: View {
    let movie: Movie
    var thumbnailType: MovieThumbnailType = .poster()
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        containerView
        .onAppear {
            switch thumbnailType {
            case .backdrop:
                imageLoader.loadImage(with: movie.backgroundURL)

            case .poster:
                imageLoader.loadImage(with: movie.posterURL)
            }
        }
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .backdrop = thumbnailType {
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                imageView
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(1)
            }
        } else {
            imageView
        }
    }
    
    private var imageView: some View {
        ZStack {
            Color.gray.opacity(0.4)
            
            if case .poster(let showTitle) = thumbnailType, showTitle {
                Text(movie.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .lineLimit(4)
            }
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
            }
        }
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct MoviePosterCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieThumbnailView(
                movie: Movie.stubbedMovie,
                thumbnailType: .backdrop
            )
            .aspectRatio(
                16/9,
                contentMode: .fit
            )
            .frame(
                height: 160
            )
        }
    }
}
