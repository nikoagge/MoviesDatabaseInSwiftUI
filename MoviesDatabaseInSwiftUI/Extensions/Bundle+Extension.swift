//
//  Bundle+Extension.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 17/7/23.
//

import Foundation

extension Bundle {
    func loadBundleAndDecodedData<T: Codable>(fileName: String) throws -> T? {
        guard let url = url(forResource: fileName, withExtension: "json") else { return nil }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utilities.jsonDecoder
        let decodedData = try jsonDecoder.decode(
            T.self,
            from: data
        )
        
        return decodedData
    }
}
