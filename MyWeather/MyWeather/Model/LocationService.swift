//
//  LocationService.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

import Foundation


//MARK:  위도 경도를 싱글톤으로 구현
/// 위도, 경도 싱글톤 클래스
final class LocationService {
    static var shared = LocationService()
    
    var longtitude: Double?
    var latitude: Double?
}
