//
//  Movie.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan Marat on 9/6/22.
//

import Foundation

struct MovieRoot: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    var id: Int
    var overview: String
    var title: String
    var posterImageUrlPrefix: String

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title
        case posterImageUrlPrefix = "poster_path"
    }
    
    struct Constants {
        static let baseImageUrl = "https://image.tmdb.org/t/p/"
        static let logoSize = "w45"
        static let largeImageSize = "w500"
    }
    
    func getThumbnailImageUrl() -> String {
        return "\(Constants.baseImageUrl)\(Constants.logoSize)\(posterImageUrlPrefix)"
    }
    
    func getLargeImageUrl() -> String {
        return "\(Constants.baseImageUrl)\(Constants.largeImageSize)\(posterImageUrlPrefix)"
    }
}
