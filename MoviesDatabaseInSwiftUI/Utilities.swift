//
//  Utilities.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import Foundation

final class Utilities {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        return dateFormatter
    }()
}
