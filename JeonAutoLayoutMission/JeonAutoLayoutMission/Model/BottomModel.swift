//
//  BottomModel.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

struct BottomModel {
    let title: String
    let subTitle: String
    let numberOfParticipants: String
    let image: UIImage
    let isStar: Bool
    let isMessagePresent: Bool
    let messageFromWho: [MessageFromWho]?
}

struct MessageFromWho: Hashable {
    var id: UUID = UUID()
    
    let userIcon: UIImage
    let from: String
    let beforeTime: String
}
