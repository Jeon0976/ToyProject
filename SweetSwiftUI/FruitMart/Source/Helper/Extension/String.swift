//
//  String.swift
//  FruitMart
//
//  Created by 전성훈 on 2023/06/05.
//  Copyright © 2023 Giftbot. All rights reserved.
//

import Foundation


extension String {
    func splitText() -> String {
        guard !self.isEmpty else { return self }
        if self.count < 10 { return self }
        
        let centerIdx = self.index(self.startIndex, offsetBy: self.count / 2)
        let centerSpaceIdx = self[..<centerIdx].lastIndex(of: " ")
        ?? self[centerIdx...].firstIndex(of: " ")
        ?? self.index(before: self.endIndex)
        let afterSpaceIdx = self.index(after: centerSpaceIdx)
        
        let lhsString = self[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = self[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
        
        return String(lhsString + "\n" + rhsString)
    }

}
