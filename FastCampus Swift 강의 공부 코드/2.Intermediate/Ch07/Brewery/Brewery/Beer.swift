//
//  beer.swift
//  Brewery
//
//  Created by 전성훈 on 2022/09/05.
//

import Foundation

struct Beer: Decodable {
    let id : Int?
    let name, taglineString, description, brewersTips, imageURL : String?
    let foodPairing : [String]?
    
    var tagLine: String {
        let tags = taglineString?.components(separatedBy: ", ")
        let hastags = tags?.map{
            "#" + $0.replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: ".", with: "")
               // .replacingOccurrences(of: ",", with: " #")
        }
        return hastags?.joined(separator: " ") ?? ""
    }
    
    enum CodingKeys : String, CodingKey {
        case id, name, description
        case taglineString = "tagline"
        case imageURL = "image_url"
        case brewersTips = "brewers_tips"
        case foodPairing = "food_pairing"
    }
}
