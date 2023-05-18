//
//  WeatherResponseModel.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

import Foundation


struct WeatherResponseModel: Decodable {
    var weatherDetail: [WeatherDetail]
    var temp: Temp
    var location: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDetail = "weather"
        case temp = "main"
        case location = "name"
    }
}


struct WeatherDetail: Decodable {
    var imageCode: String
    
    var imageURL: URL? { URL(string: "https://openweathermap.org/img/wn/10d@\(imageCode).png")}
    
    enum CodingKeys: String, CodingKey {
        case imageCode = "icon"
    }
}

struct Temp: Decodable {
    var nowTempK: Double
    var lowTempK: Double
    var maxTempK: Double
    
    let kelvinToCelsius = 273.15
    
    var nowTemp: String {
        let nowC = nowTempK - kelvinToCelsius
        return String(nowC)
    }
    
    var lowTemp: String {
        let lowC = lowTempK - kelvinToCelsius
        return String(lowC)
    }
    
    var maxTemp: String {
        let maxC = maxTempK - kelvinToCelsius
        return String(maxC)
    }
    
    enum CodingKeys: String, CodingKey {
        case nowTempK = "temp"
        case lowTempK = "temp_min"
        case maxTempK = "temp_max"
    }
}

