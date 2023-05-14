//
//  ViewController.swift
//  SerialSyncProject
//
//  Created by Allen on 2020/02/05.
//  Copyright © 2020 allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let nameList = [("재석", "유"), ("구라", "김"), ("나래", "박"), ("동엽", "신"), ("세형", "양")]
    
    let concurrentQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 🎾 경쟁상황 발생하는 경우
        changeNameRace()
        
        // 🎾 경쟁상황 발생하지 않는 Thread-Safe처리의 경우
//        changeNameSafely()
        
        // 🎾 쓰기 작업만 Sync처리한 경우(Thread-Safe문제는 발생)
//        WriteSyncronously()
        
        // 🎾 Thread-Safe면서 Print도 제대로 하려면, 케이스를 고려한 설계
//        changeNameSafelyPrintRightly()

    }
    
    
    
    func changeNameRace() {
        
        let person = Person(firstName: "길동", lastName: "Anderson")
        let nameChangeGroup = DispatchGroup()
        
        // 비동기로 커스텀 동시큐에 보내서 (동시적으로)이름 바꾸기
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: nameChangeGroup) {
                usleep(UInt32(10_000 * idx))
                person.changeName(firstName: name.0, lastName: name.1)
                print("현재의 이름: \(person.name)")
            }
        }
        
        // 디스패치 그룹 작업이 다 끝나면 마지막 이름 알려주기
        nameChangeGroup.notify(queue: DispatchQueue.main) {
            print("마지막 이름은?: \(person.name)")
        }
        
        // 다할때까지 기다리기
        nameChangeGroup.wait()
    }
    

    func changeNameSafely() {
        let threadSafeNameGroup = DispatchGroup()
        
        let threadSafeSyncPerson = ThreadSafeSyncPerson(firstName: "길동", lastName: "홍")
        
        // Thread-safe 객체를 동시작업으로 진행해보기
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: threadSafeNameGroup) {
                usleep(UInt32(10_000 * idx))
                threadSafeSyncPerson.changeName(firstName: name.0, lastName: name.1)
                // 프린트하는 자체도 큐에 들어가는 순서에 따라 이상한순서로 프린트되는 일이 발생할 수도 있음
                // 그럼에도 불구하고 여러쓰레드에서 한꺼번에 접근을 막기 때문에 Thread-safe처리는 맞음
                print("현재 이름(safe): \(threadSafeSyncPerson.name)")
            }
        }
        
        threadSafeNameGroup.notify(queue: DispatchQueue.main) {
            print("마지막 이름은?(safe): \(threadSafeSyncPerson.name)")
        }
    }
    
    
    func WriteSyncronously() {
        let writeSyncNameGroup = DispatchGroup()
        
        let writeSyncPerson = WriteSyncPerson(firstName: "길동", lastName: "홍")
        
        // 동시작업으로 진행해보기
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: writeSyncNameGroup) {
                usleep(UInt32(10_000 * idx))
                writeSyncPerson.changeName(firstName: name.0, lastName: name.1)
                // 프린트하는 자체는 동시큐에서 일어날수있도록(다만,엄격한 의미에서 Thread-safe는 아님)
                print("현재 이름(write-safe): \(writeSyncPerson.name)")
            }
        }
        
        writeSyncNameGroup.notify(queue: DispatchQueue.main) {
            print("마지막 이름은?(write-safe): \(writeSyncPerson.name)")
        }
    }
    
    
    func changeNameSafelyPrintRightly() {
        let threadSafeNameGroup = DispatchGroup()
        
        let threadSafePrintRightPerson = ThreadSafePrintRightPerson(firstName: "길동", lastName: "홍")
        
        // 동시작업으로 진행해보기
        for (idx, name) in nameList.enumerated() {
            concurrentQueue.async(group: threadSafeNameGroup) {
                usleep(UInt32(10_000 * idx))
                threadSafePrintRightPerson.changeName(firstName: name.0, lastName: name.1)
            }
        }
        
        threadSafeNameGroup.notify(queue: DispatchQueue.main) {
            print("마지막 이름은?(thread-safe): \(threadSafePrintRightPerson.name)")
        }
    }
    
    

}

