//
//  MTMapViewError.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/11.
//

import Foundation

enum MTMapViewError: Error {
    case failedUpdatingCurrentLocation
    case locationAuthorizationDenied
    
    var errorDescription: String {
        switch self {
        case .failedUpdatingCurrentLocation:
            return "현재 위치를 불러오지 못했습니다. 잠시 후 다시 시도해주십시오."
        case .locationAuthorizationDenied:
            return "위치 정보를 비활성화하여 현재 위치를 알 수 없습니다."
        }
    }
}
