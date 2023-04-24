//
//  BookSearchManager.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Alamofire
import Foundation

struct BookSearchManager {
    func request(from keyword : String, completionHandler: @escaping (([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        
        let parameters = BookSearchRequestModel(query: keyword)
        
        // ID : ie04mHhHFUiO1i9Pzzgw
        // Secret : Nr6VZbR7ac
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id" : "ie04mHhHFUiO1i9Pzzgw",
            "X-Naver-Client-Secret" : "Nr6VZbR7ac"
        ]
        
        AF.request(url,method: .get,parameters: parameters,headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
