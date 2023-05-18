//
//  WeatherRequestManager.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

import Foundation


//MARK: URLSession 구조체
struct WeatherRequestManager {
    
    //MARK: OpenWeather 주소 값
    let scheme = "https"
    let openWeather = "api.openweathermap.org"
    let openWeatherPath = "/data/2.5/weather"
    
    //MARK: OpenWeahter 키 값
    let lat = "lat"
    let lon = "lon"
    let id = "appid"
    
    //MARK: OpenWeather apiKey
    let apiKey = "baf0548634d00b30b393182fbbf46c53"
    
    
    //MARK: URL 요청 메서드 구현
    func request(_ latitude: Double, _ longtitude: Double, completionHandler: @escaping ((WeatherResponseModel) -> Void)) {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = openWeather
        urlComponents.path = openWeatherPath
        urlComponents.queryItems = [
            URLQueryItem(name: lat, value: String(latitude)),
            URLQueryItem(name: lon, value: String(longtitude)),
            URLQueryItem(name: id, value: apiKey)
        ]
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                if let weatherData = try? JSONDecoder().decode(WeatherResponseModel.self, from: data) {
                    completionHandler(weatherData)
                }
            }
        }.resume()
    }
}
