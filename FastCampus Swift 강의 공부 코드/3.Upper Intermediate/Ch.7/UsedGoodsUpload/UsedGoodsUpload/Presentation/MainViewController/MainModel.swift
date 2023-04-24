//
//  MainModel.swift
//  UsedGoodsUpload
//
//  Created by 전성훈 on 2022/11/04.
//

import Foundation


struct MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title, message: message)
    }
    
}
