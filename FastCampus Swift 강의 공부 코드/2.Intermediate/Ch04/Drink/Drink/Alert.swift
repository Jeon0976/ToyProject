//
//  Alert.swift
//  Drink
//
//  Created by 전성훈 on 2022/09/01.
//

import Foundation

struct Alert: Codable {
    var id : String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time : String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem : String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a"
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
