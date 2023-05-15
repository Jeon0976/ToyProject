//
//  UserInformation.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/13.
//

import UIKit

class UserInformation {
    static let shared = UserInformation()
    
    var id: String?
    var password: String?
    var profile: UIImage?
    var information: String?
    var phoneNumber: String?
    var birthDate: String?
    
    private init() { }
    
    func allClear() {
        id = nil
        password = nil
        profile = nil
        information = nil
        phoneNumber = nil
        birthDate = nil
    }
}

