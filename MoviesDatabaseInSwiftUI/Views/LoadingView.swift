//
//  LoadingView.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 18/7/23.
//

import SwiftUI

struct LoadingView: View {
    let error: NSError?
    let isLoading: Bool
    let retryAction: (() -> ())?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if let error = error {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error.localizedDescription)
                            .font(.headline)
                        
                        if let retryAction = retryAction {
                            Button(action: retryAction) {
                                Text("Retry")
                            }
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(
            error: nil,
            isLoading: true,
            retryAction: nil
        )
    }
}
