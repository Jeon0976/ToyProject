//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Sync메서드를 사용하면 안되는 경우
//: ### 2)현재의 큐에서 현재의 큐로 sync 메서드를 사용하면 안된다.

//: "Person"객체를 사용해서, 이름바꿔보는 예제
let person = Person(firstName: "길동", lastName: "홍")


// 🎾 Sources 폴더에 Person.swift파일을 먼저 확인할 필요 🎾
// Person객체 내부에서 이름을 바꾸는 "changeName"메서드는
// "DispatchQueue.global().sync"로 구현되어있음
person.changeName(firstName: "꺽정", lastName: "임")
person.name


//: 본 예제는 동시큐이기 때문에 실행시마다 항상 Deadlock(교착상황)이 생기지는 않으나, 교착상황이 생길 수 있는 가능성을 내포하고 있는 경우이므로(구조 위주로 참고)

let nameList = [("재석", "유"), ("구라", "김"), ("나래", "박"), ("동엽", "신"), ("세형", "양")]


// 반복문으로 디폴트 글로벌큐로 비동기적으로 보내기
for (idx, name) in nameList.enumerated() {
    
    DispatchQueue.global().async {
        
        usleep(UInt32(10_000 * idx))
        // person객체의 내부에서 다시 "DispatchQueue.global().sync"를 사용하고 있음을 인지
        person.changeName(firstName: name.0, lastName: name.1)
        print("현재의 이름: \(person.name)")
        
    }
}



sleep(5)


PlaygroundPage.current.finishExecution()
//: [Next](@next)
