//
//  MovieSearchResponseModel.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
