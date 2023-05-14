//
//  ThreadSafePerson.swift
//  TSanExample
//
//  Created by Audrey M Tam on 16/09/2016.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation

class ThreadSafePerson: Person {
    
    let isolationQueue = DispatchQueue(label: "com.raywenderlich.person.isolation", attributes: .concurrent)
    
    // 🎾 쓰기 - 비동기(async) 배리어 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        isolationQueue.async(flags: .barrier) {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 🎾 읽기 - 동기(sync) 작업으로 설정
    override var name: String {
        return isolationQueue.sync {
            return super.name
        }
    }
}
