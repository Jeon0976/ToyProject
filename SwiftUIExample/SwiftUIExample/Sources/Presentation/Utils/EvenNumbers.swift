//
//  EvenNumbers.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import SwiftUI

@resultBuilder
struct EvenNumbers {
    static func buildBlock(_ numbers: Int...) -> [Int] {
        numbers.filter { $0.isMultiple(of: 2) }
    }
    static func buildBlock(_ numbers: [Int]) -> [Int] {
        return numbers
    }
}
