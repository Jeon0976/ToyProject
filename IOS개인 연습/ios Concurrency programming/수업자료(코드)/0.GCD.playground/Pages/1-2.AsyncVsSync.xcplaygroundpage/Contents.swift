//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # 비동기(async) VS 동기(sync)

let queue = DispatchQueue.global()


func task1() {
    print("Task 1 시작")
    sleep(1)
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    sleep(4)
    print("Task 3 완료★")
}

func task4() {
    print("Task 4 시작")
    sleep(3)
    print("Task 4 완료★")
}


//: # 비동기(작업) 예시
//: ### 작업을 시작시키기만 하고, 끝나는 것은 기다리지 않고 다음 작업을 진행함

// 시간을 재보기 위한 함수 활용
//timeCheck {      // 1초보다 훨씬 미만의 시간이 나온다.
queue.async {
    task1()
}

queue.async {
    task2()
}

queue.async {
    task3()
}
//}



//: # 동기(작업) 예시
//: ### 작업을 시작시키고, 끝나는 것을 기다렸다가 다음 작업을 진행함


task1()
task2()
task3()
task4()


// ★ 코드가 순서적으로 있을때, (비동기적으로 보내는 것이 아니라면) 위의 작업이
// 다 끝나야 아래작업이 시작한다는 것을 이제는 꼭 인지할 필요 ★

print("====================")


timeCheck {
    queue.sync {
        task1()
    }
    
    queue.sync {
        task2()
    }
    
    queue.sync {
        task3()
    }
    
    queue.sync {
        task4()
    }
}




PlaygroundPage.current.finishExecution()



//: [Next](@next)
