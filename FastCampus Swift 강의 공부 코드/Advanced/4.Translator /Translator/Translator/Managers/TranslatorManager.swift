//
//  TranslatorManager.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/14.
//

import Alamofire
import Foundation

struct TranslatorManager {
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(from text: String,
                   completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else {return}
        // url이 존재하다는 담보가 되어있음
        let requestModel = TranslateRequestModel(source: sourceLanguage.languageCode,
                                                 target: targetLanguage.languageCode,
                                                 text: text)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "ErJgxri7nLSKPgFXUnEO",
             "X-Naver-Client-Secret": "TSUl5tzGil"
        ]
        
        AF
            .request(url,method: .post,parameters: requestModel,headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result) : completionHandler(result.translatedText)
                case .failure(let error) : print(error.localizedDescription)
                }
            }
            .resume()
    }
}
