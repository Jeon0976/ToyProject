//
//  NewsSearchManager.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import Foundation

import Alamofire

protocol NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    )
}

struct NewsSearchManager: NewsSearchManagerProtocol {
    func request(
        from keyword: String,
        start: Int,
        display: Int,
        completionHandler: @escaping ([News]) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else {return}
        
        let parameters = NewsRequestModel(
            start: start,
            display: display,
            query: keyword
        )
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "ie04mHhHFUiO1i9Pzzgw",
            "X-Naver-Client-Secret": "Nr6VZbR7ac"
        ]
        
        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: NewsResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
