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
}

//adult: false,
//backdrop_path: "/ugS5FVfCI3RV0ZwZtBV3HAV75OX.jpg",
//genre_ids: [
//16,
//878,
//28
//],
//id: 610150,
//original_language: "ja",
//original_title: "ドラゴンボール超 スーパーヒーロー",
//overview: "The Red Ribbon Army, an evil organization that was once destroyed by Goku in the past, has been reformed by a group of people who have created new and mightier Androids, Gamma 1 and Gamma 2, and seek vengeance against Goku and his family.",
//popularity: 12401.679,
//poster_path: "/rugyJdeoJm7cSJL1q4jBpTNbxyU.jpg",
//release_date: "2022-06-11",
//title: "Dragon Ball Super: Super Hero",
//video: false,
//vote_average: 8,
//vote_count: 1153
