//
//  MoviesStore.swift
//  MoviesDatabaseInSwiftUI
//
//  Created by Nikos Aggelidis on 16/7/23.
//

import Foundation

final class MoviesStore: MoviesService {
    static let shared = MoviesStore()
    
    private init() {}
    
    private let apiKey = "APIKEY"
    private let baseURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utilities.jsonDecoder
    
    func fetchMovies(
        from moviesListEndPoint: MoviesListEndPoints,
        onCompletion: @escaping (Result<Movies, MoviesError>) -> ()
    ) {
        guard let url = URL(string: "\(baseURL)/movie/\(moviesListEndPoint.rawValue)") else {
            onCompletion(.failure(.invalidEndpoint))
            
            return
        }
        getDataFromService(
            url: url,
            onCompletion: onCompletion
        )
    }
    
    func fetchMovie(
        for id: Int,
        onCompletion: @escaping (Result<Movie, MoviesError>) -> ()
    ) {
        guard let url = URL(string: "\(baseURL)/movie/\(id)") else {
            onCompletion(.failure(.invalidEndpoint))
            
            return
        }
        getDataFromService(
            url: url,
            parameters: ["append_to_response": "videos, credits"],
            onCompletion: onCompletion
        )
    }
    
    func searchForMovies(
        basedOn query: String,
        onCompletion: @escaping (Result<Movies, MoviesError>) -> ()
    ) {
        guard let url = URL(string: "\(baseURL)/search/movie") else {
            onCompletion(.failure(.invalidEndpoint))
            
            return
        }
        getDataFromService(
            url: url,
            parameters: [
                "language": "en-US",
                "include_adult": "true",
                "region": "US",
                "query": query
            ],
            onCompletion: onCompletion
        )
    }
    
    private func getDataFromService<T: Codable>(
        url: URL,
        parameters: [String: String]? = nil,
        onCompletion: @escaping (Result<T, MoviesError>) -> ()
    ) {
        guard var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) else {
            onCompletion(.failure(.invalidEndpoint))
            
            return
        }
        
        var queryItems = [URLQueryItem(
            name: "api_key",
            value: apiKey)
        ]
        
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(
                name: $0.key,
                value: $0.value)
            })
            
            urlComponents.queryItems = queryItems
            
            guard let url = urlComponents.url else {
                onCompletion(.failure(.invalidEndpoint))
                
                return
            }
            
            urlSession.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                if error != nil {
                    DispatchQueue.main.async {
                        onCompletion(.failure(.apiError))
                    }
                    
                    return
                }
                
                guard let successfulResponse = response as? HTTPURLResponse, 200..<300 ~= successfulResponse.statusCode else {
                    DispatchQueue.main.async {
                        onCompletion(.failure(.invalidResponse))
                    }
                    
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        onCompletion(.failure(.noData))
                    }
                    
                    return
                }
                
                do {
                    let decodedData = try self.jsonDecoder.decode(
                        T.self,
                        from: data
                    )
                    DispatchQueue.main.async {
                        onCompletion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        onCompletion(.failure(.serializationError))
                    }
                }
            }.resume()
        }
    }
}
