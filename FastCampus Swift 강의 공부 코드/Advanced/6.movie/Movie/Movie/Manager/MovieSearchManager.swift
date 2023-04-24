//
//  MovieSearchManager.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import Foundation

import Alamofire

// UnitTest를 위한 protocol 생성
protocol MovieSearchManagerProtocol {
    func reqeuset(from keyword: String, completionHandler: @escaping([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func reqeuset(from keyword: String, completionHandler: @escaping([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else {return}

        let parameters = MovieSearchRequestModel(query: keyword)

        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "ie04mHhHFUiO1i9Pzzgw",
            "X-Naver-Client-Secret": "Nr6VZbR7ac"
        ]

        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: MovieSearchResponseModel.self) { response in
            switch response.result {
            case.success(let result):
                completionHandler(result.items)
            case.failure(let error):
                print(error)
            }
        }
        .resume()
    }
}
