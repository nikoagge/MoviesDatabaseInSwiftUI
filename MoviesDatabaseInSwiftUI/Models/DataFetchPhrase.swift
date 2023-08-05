//
//  DataFetchPhrase.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 3/8/23.
//

import Foundation

enum DataFetchPrase<V> {
    case empty
    case failure(Error)
    case success(V)
    
    var value: V? {
        if case .success(let v) = self {
            return v
        }
        
        return nil
    }
}
