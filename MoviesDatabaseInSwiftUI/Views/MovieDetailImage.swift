//
//  MovieDetailImage.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 31/7/23.
//

import SwiftUI

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct MovieDetailImage_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailImage(imageURL: Movie.stubbedMovie.backgroundURL)
    }
}
