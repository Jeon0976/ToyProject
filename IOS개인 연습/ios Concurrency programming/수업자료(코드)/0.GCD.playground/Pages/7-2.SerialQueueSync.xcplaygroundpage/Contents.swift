//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 시리얼큐와 Sync
//: ### 시리얼큐와 Sync메서드를 이용한 엄격한 Thread-safe처리

//: ## 앞에서 참고했던 예제
//: 6-1.AnotherRaceCondition예제
let person = Person(firstName: "길동", lastName: "홍")


person.changeName(firstName: "꺽정", lastName: "임")
person.name


let nameList = [("재석", "유"), ("구라", "김"), ("나래", "박"), ("동엽", "신"), ("세형", "양")]

let concurrentQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)

let nameChangeGroup = DispatchGroup()


//: 비동기작업(여러쓰레드를 사용)의 경우, 한개의 데이터에 접근할때 항상 Thread-safe를 고려해야함

// 이름 바꾸는 작업을 비동기적으로 여러번 실행
for (idx, name) in nameList.enumerated() {
    concurrentQueue.async(group: nameChangeGroup) {
        usleep(UInt32(10_000 * idx))
        person.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(person.name)")
    }
}

nameChangeGroup.notify(queue: DispatchQueue.global()) {
    print("마지막 이름은?: \(person.name)")
}

nameChangeGroup.wait()


//: Thread-safe 처리되지 않아, 일관된 값을 얻을 수 없었음.

sleep(4)



//: ## 1) 시리얼큐 및 Sync로 처리된 엄격한 Person객체
//: ### 1개의 쓰레드로 시리얼하게, 동기적으로 동작하도록 함
// 엄격한 쓰레드-세이프 처리된 객체
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
            var result = ""
            result = super.name
            return result
        }
    }
    
    // Apple WWDC에서 제시한 방법
    //    override var name: String {
    //        serialQueue.sync {
    //            return super.name
    //        }
    //    }
}


print("\n=== Serial-sync처리된 객체로 확인 ===")

let threadSafeNameGroup = DispatchGroup()

let threadSafeSyncPerson = ThreadSafeSyncPerson(firstName: "길동", lastName: "홍")

for (idx, name) in nameList.enumerated() {
    concurrentQueue.async(group: threadSafeNameGroup) {
        usleep(UInt32(10_000 * idx))
        threadSafeSyncPerson.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(threadSafeSyncPerson.name)")
    }
}

threadSafeNameGroup.notify(queue: DispatchQueue.global()) {
    print("마지막 이름은?: \(threadSafeSyncPerson.name)")
}





//: ## 2) 쓰기 작업만 시리얼큐+Sync 처리된 Person객체
//: ### 읽기는 동시적으로 접속 허용하게 만듦(제대로 프린트됨)
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


print("\n=== 쓰기 작업만 Serial-Sync처리된(Thread-safe하지 않은) 객체로 확인 ===")

let writeSyncNameGroup = DispatchGroup()

let writeSyncPerson = WriteSyncPerson(firstName: "길동", lastName: "홍")

for (idx, name) in nameList.enumerated() {
    concurrentQueue.async(group: writeSyncNameGroup) {
        usleep(UInt32(10_000 * idx))
        writeSyncPerson.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(writeSyncPerson.name)")
    }
}

writeSyncNameGroup.notify(queue: DispatchQueue.global()) {
    print("마지막 이름은?: \(writeSyncPerson.name)")
    PlaygroundPage.current.finishExecution()
}






//: [Next](@next)
