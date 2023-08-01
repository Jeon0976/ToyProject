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
    let image: UIImage
    let isStar: Bool
    let isMessagePresent: Bool
    let messageFromWho: [MessageFromWho]
}

struct MessageFromWho {
    let from: String
    let beforeTime: String
}
