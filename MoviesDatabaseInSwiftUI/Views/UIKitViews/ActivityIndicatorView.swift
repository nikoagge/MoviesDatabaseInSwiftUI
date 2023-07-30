//
//  ActivityIndicatorView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> some UIView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }
}
