//
//  DataBinding.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/02.
//

import UIKit

extension ViewController {
    func topDataBinding() {
        let topTitle =
            """
            오전, 오후 풀타임 빡코딩 스터디
            빡코딩 하는 사람만
            """
        let topSubTitle =
            """
            하루 10시간 이상 빡코딩 하실분 오세요~
            취준생, 현직 개발자, 이직을 위한 빡코딩, 취미 개발등
            모두 환영입니다!
            """
        let topImage = UIImage(named: "ic_heart")!
        
        let topModel = TopModel(
            title: topTitle,
            subTitle: topSubTitle,
            image: topImage
        )
        
        topView.setData(topModel)
    }
    
    func bottomDataBinding() {
        let bottomTitle = "풀타임 빡코 모임방"
        let bottomSubTitle = "24시간 빡코딩할 분들 모집합니다!!"
        let bottomParticipants = "활동중 맴버 249명 / 정원 250명"
        let bottomUserImage = UIImage(named: "Rectangle 460")!
        
        let from = "빡코딩"
        let beforeTime = "22시간 전"
        let icon = UIImage(named: "Group 48095722")!
        
        let messageFrom = [MessageFromWho(userIcon: icon, from: from, beforeTime: beforeTime)]
        
        let bottomModel = BottomModel(
            title: bottomTitle,
            subTitle: bottomSubTitle,
            numberOfParticipants: bottomParticipants,
            image: bottomUserImage,
            isStar: true,
            isMessagePresent: true,
            messageFromWho: messageFrom
        )
        
        bottomView.setData(bottomModel)
    }
}
