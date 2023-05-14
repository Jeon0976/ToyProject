//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Dispatch Barrier(디스패치 배리어)
//: ### 조금 더 효율적인 Thread-safe 처리

//: ## 앞에서 참고했던 예제
//: 6-1.AnotherRaceCondition예제
let person = Person(firstName: "길동", lastName: "홍")


person.changeName(firstName: "꺽정", lastName: "임")
person.name


let nameList = [("재석", "유"), ("구라", "김"), ("나래", "박"), ("동엽", "신"), ("세형", "양")]

let concurrentQueue = DispatchQueue(label: "com.inflearn.concurrent", attributes: .concurrent)
let nameChangeGroup = DispatchGroup()


//: 비동기작업(여러쓰레드를 사용)의 경우, 항상 Thread-safe를 고려해야함
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



//: ## 디스패치 배리어처리된 Thread-safe 객체
//: ### 배리어작업은 동시큐에서 시리얼하게 동작하도록 함
// 쓰레드-세이프 처리된 객체
class BarrierThreadSafePerson: Person {
    
    let newConcurrentQueue = DispatchQueue(label: "com.inflearn.person.newConcurrent", attributes: .concurrent)
    
    // 🎾 쓰기 - 동시 + 배리어(Barrier) 작업으로 설정
    override func changeName(firstName: String, lastName: String) {
        newConcurrentQueue.async(flags: .barrier) {
            super.changeName(firstName: firstName, lastName: lastName)
        }
    }
    
    // 🎾 읽기 - 동시 + 동기(sync) 작업으로 설정
    override var name: String {
        newConcurrentQueue.sync {
            return super.name
        }
    }
}


print("\n=== Thread-safe처리된 객체로 확인 ===")

let threadSafeNameGroup = DispatchGroup()

let barrierThreadSafePerson = BarrierThreadSafePerson(firstName: "길동", lastName: "홍")

for (idx, name) in nameList.enumerated() {
    concurrentQueue.async(group: threadSafeNameGroup) {
        usleep(UInt32(10_000 * idx))
        barrierThreadSafePerson.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(barrierThreadSafePerson.name)")
    }
}

threadSafeNameGroup.notify(queue: DispatchQueue.global()) {
    print("마지막 이름은?: \(barrierThreadSafePerson.name)")
}

// 위에서 장벽 작업은 changeName뿐이기 때문에, print문은 장벽 작업이 아니기 때문에
// 동일하게 출력되는 경우도 가끔 생길 수 있음. (그림 확인)


sleep(4)









//: ## 오퍼레이션큐로 처리한 배리어 작업(블락오퍼레이션)
//: ### 디스패치 그룹대신 블락오퍼레이션으로 처리해보기
print("\n=== Threadsafe Operation 작업 ===")


let blockOperation = BlockOperation()
let barrierThreadSafePerson2 = BarrierThreadSafePerson(firstName: "길동", lastName: "홍")

for (idx, name) in nameList.enumerated() {
    blockOperation.addExecutionBlock {
        usleep(UInt32(10_000 * idx))
        barrierThreadSafePerson2.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(barrierThreadSafePerson2.name)")
    }
}

blockOperation.completionBlock = {
    print("마지막 이름은?: \(barrierThreadSafePerson2.name)")
    PlaygroundPage.current.finishExecution()
}


// 동기적으로 실행하기
blockOperation.start()


// 오퍼레이션큐에 넣어서 비동기적으로 처리
let queue = OperationQueue()

queue.addOperation(blockOperation)


//: [Next](@next)
