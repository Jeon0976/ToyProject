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
    private let scheme = "https"
    private let openWeather = "api.openweathermap.org"
    private let openWeatherPath = "/data/2.5/weather"
    
    //MARK: OpenWeahter 키 값
    private let lat = "lat"
    private let lon = "lon"
    private let id = "appid"
    
    //MARK: OpenWeather apiKey
    private var apiKey = Bundle.main.apiKey
    
    //MARK: URL 요청 메서드 구현
    func request(_ latitude: Double, _ longtitude: Double, completionHandler: @escaping ((WeatherResponseModel) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = openWeather
        urlComponents.path = openWeatherPath
        urlComponents.queryItems = [
            URLQueryItem(name: lat, value: String(latitude)),
            URLQueryItem(name: lon, value: String(longtitude)),
            URLQueryItem(name: id, value: apiKey!)
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

extension Bundle {
    var apiKey: String? {
        guard let file = self.path(forResource: "API", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            print("plist error")
            return nil
        }
        return key
    }
}
