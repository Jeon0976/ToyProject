//
//  BookSearchResponseModel.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/22.
//

import Foundation

struct BookSearchResponseModel: Decodable {
    // let items: [Book]
    // 위처럼 상수로 파씽했을 때, items가 없다면 decoding error가 된다. 하지만 배열 자체에서 배열이없다고 decoding error가 되면 조금 이상?? 뭔 말?? 그래서 변수로 설정?? 뭔 말
    var items: [Book] = []
}

