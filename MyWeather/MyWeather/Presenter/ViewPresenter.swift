//
//  ViewPresenter.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

import UIKit
import CoreLocation


protocol ViewProtocol: NSObject {
    func attribute()
    func layout()
    func reverseHidden()
    func updateUI(_ weather: Weather,_ image: UIImage)
}


final class ViewPresenter: NSObject {
    weak var viewController: ViewProtocol?
    
    private let requestManager = WeatherRequestManager()
    
    private let locationManager = CLLocationManager()
    
    private var weather: Weather?
    
    // 비동기 처리 location 이후 실행 할 URLSession을 위한 클로저
    private var afterUpdateLocation:(() -> Void)?
    
    
//    var weahterModel
    
    init(viewController: ViewProtocol) {
        self.viewController = viewController
    }
    
    
    func viewDidLoad() {
        viewController?.attribute()
        viewController?.layout()
    }
    
    // MARK: Button Tap 했을 시, 비동기 처리
    func buttonTapped() {
        guard let latitude = LocationService.shared.latitude,
              let longtitude = LocationService.shared.longtitude else { return }

        requestManager.request(latitude, longtitude) { [weak self] weatherRespnseModel in
            self?.weather = Weather(
                imageURL: weatherRespnseModel.weatherDetail.first?.imageURL,
                nowTemp: weatherRespnseModel.temp.nowTemp,
                lowTemp: weatherRespnseModel.temp.lowTemp,
                maxTemp: weatherRespnseModel.temp.maxTemp,
                location: weatherRespnseModel.location
            )
            guard let weather = self?.weather else { return }

            var image = UIImage()

            URLSession.shared.dataTask(with: weather.imageURL!) { data, response, error in
                if let error = error { print(error.localizedDescription) }

                if let data = data {
                    image = UIImage(data: data)!
                }
                
                DispatchQueue.main.async {
                    self?.viewController?.reverseHidden()
                    self?.viewController?.updateUI(weather, image)
                }
            }.resume()
        }
    }
    
    func locationAuthorizaion() {
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .denied:
            print("왜 거절함?")
        case .notDetermined, .restricted:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationUpdate(completionHandler: @escaping (() -> Void)) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        self.afterUpdateLocation = completionHandler
    }
    
    func locationUpdate() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }

}

extension ViewPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        LocationService.shared.latitude = location.coordinate.latitude
        LocationService.shared.longtitude = location.coordinate.longitude
        
        locationManager.stopUpdatingLocation()
        afterUpdateLocation!()
    }
}


// TODO:
// 1. ToyProject README 작성
//  - 데이터 비동기 처리 구체화 및 오퍼래이션으로 변경 필수 (클로저 -> 오퍼레이션)
//  - MVP 패턴에서 비동기 처리 정리
// 2. plist를 활용한 API Key 처리 정리

