//
//  ViewController.swift
//  TSanExample
//
//  Created by Audrey M Tam on 16/09/2016.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let nameList = [("Charlie", "Cheesecake"), ("Delia", "Dingle"), ("Eva", "Evershed"), ("Freddie", "Frost"), ("Gina", "Gregory")]
    
    let workerQueue = DispatchQueue(label: "com.raywenderlich.worker", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 🎾 경쟁상황 발생하는 경우
        changeNameRace()
        
        // 🎾 경쟁상황 발생하지 않는 Thread-Safe처리의 경우
//        changeNameSafely()
    }
    
    func changeNameRace() {
        
        let nameChangingPerson = Person(firstName: "Alison", lastName: "Anderson")
        let nameChangeGroup = DispatchGroup()
        
        // 비동기로 커스텀 동시큐에 보내서 (동시적으로)이름 바꾸기
        for (idx, name) in nameList.enumerated() {
            workerQueue.async(group: nameChangeGroup) {
                usleep(UInt32(10_000 * idx))
                nameChangingPerson.changeName(firstName: name.0, lastName: name.1)
                print("Current Name: \(nameChangingPerson.name)")
            }
        }
        
        // 디스패치 그룹 작업이 다 끝나면 마지막 이름 알려주기
        nameChangeGroup.notify(queue: DispatchQueue.main) {
            print("Final name: \(nameChangingPerson.name)")
        }
        
        // 다할때까지 기다리기
        nameChangeGroup.wait()
    }
    
    
    
    func changeNameSafely() {
        let threadSafeNameGroup = DispatchGroup()
        
        let threadSafePerson = ThreadSafePerson(firstName: "Anna", lastName: "Adams")
        
        // Thread-safe 객체를 동시작업으로 진행해보기
        for (idx, name) in nameList.enumerated() {
            workerQueue.async(group: threadSafeNameGroup) {
                usleep(UInt32(10_000 * idx))
                threadSafePerson.changeName(firstName: name.0, lastName: name.1)
                // 프린트하는 자체는 배리어 작업은 아님 (중복 프린트되는 일이 발생할 수도 있음)
                print("Current threadsafe name: \(threadSafePerson.name)")
            }
        }
        
        // 디스패치 그룹 작업이 다 끝나면 마지막 이름 알려주기
        threadSafeNameGroup.notify(queue: DispatchQueue.main) {
            print("Final threadsafe name: \(threadSafePerson.name)")
        }
        
    }

}

