//
//  MovieService.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan Marat on 9/6/22.
//

import Foundation
import Alamofire

class MovieService {
    struct Constants {
        static let url = "https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    }
    
    func getPopularMoviesUsingApple(completion: @escaping (Swift.Result<[Movie]?, Error>) -> Void) {
        if let url = URL(string: Constants.url) {
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("error occured \(error)")
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let moviesRootResult = try decoder.decode(MovieRoot.self,
                                                        from: data)
                        completion(.success(moviesRootResult.results))
                    } catch let error {
                        print("error during parsing data \(error)")
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
    func getPopularMoviesUsingAlamoFire(completion: @escaping (Swift.Result<[Movie]?, Error>) -> Void) {
        AF.request(Constants.url)
            .validate()
            .responseDecodable(of: MovieRoot.self) { response in
                switch response.result {
                case .success(let movieRoot):
                    completion(.success(movieRoot.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
