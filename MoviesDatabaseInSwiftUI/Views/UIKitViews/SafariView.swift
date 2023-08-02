//
//  SafariView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 2/8/23.
//

import Foundation
import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        
        return safariViewController
    }
}
