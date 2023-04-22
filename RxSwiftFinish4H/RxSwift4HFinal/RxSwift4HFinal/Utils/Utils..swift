//
//  Utils..swift
//  RxSwift4HFinal
//
//  Created by 전성훈 on 2023/04/22.
//

import Foundation

extension Int {
    func currencyKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
