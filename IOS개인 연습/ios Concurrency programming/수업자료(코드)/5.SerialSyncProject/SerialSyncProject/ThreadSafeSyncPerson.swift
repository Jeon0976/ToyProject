//
//  ThreadSafeSyncPerson.swift
//  SerialSyncProject
//
//  Created by Allen on 2020/02/05.
//  Copyright © 2020 allen. All rights reserved.
//

import Foundation


// 엄격한 Thread-safe의 경우
class ThreadSafeSyncPerson: Person {
    
    let serialQueue = DispatchQueue(label: "com.inflearn.person.serial")
    
    // 🎾 쓰기 - 시리얼 + 동기(sync) 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 🎾 읽기 - 시리얼 + 동기(sync) 작업으로 설정
    override var name: String {
        serialQueue.sync {
            return super.name
        }
    }
}

// 프린트 작업을 제대로 하게 만들수 있는 방법
// 🎾 읽기는 언제든지 접근할 수 있도록(그러나 Thread-Safety문제발생)
class WriteSyncPerson: Person {
    
    let serialQueue = DispatchQueue(label: "com.inflearn.person.serial")
    
    // 🎾 쓰기 - 시리얼 + 동기(sync) 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 🎾 읽기는 언제든지 접근할 수 있도록(그러나 Thread-Safety문제발생)
    override var name: String {
        return super.name
    }
}

// 엄격한 Thread-safe이면서 Print도 제대로..
// 🎾 객체 설계 다시할 필요
// 항상 이렇게 설계해야된다는 것이 아니고, 여기서의 케이스를 고려했을때의 설계 방식
class ThreadSafePrintRightPerson: Person {
    
    let serialQueue = DispatchQueue(label: "com.inflearn.person.serial")
    
    // 🎾 쓰기 - 시리얼 + 동기(sync) 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        serialQueue.sync {
            super.changeName(firstName: firstName, lastName: lastName)
            print("현재 이름(safe): \(self.name)")
        }
    }
    
    // 🎾 읽기 작업은 sync처리 안함
    override var name: String {
        return super.name
    }
}

