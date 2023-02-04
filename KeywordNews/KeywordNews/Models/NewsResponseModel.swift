//
//  NewsResponseModel.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/04.
//

import Foundation

struct NewsResponseModel: Decodable {
    var items: [News] = []
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
