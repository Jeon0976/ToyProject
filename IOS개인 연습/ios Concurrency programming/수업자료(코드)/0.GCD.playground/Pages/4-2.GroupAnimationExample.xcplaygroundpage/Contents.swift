//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # UIViewAnimationGroup
//: ### 그룹애니메이션 예제(참고)
// 'UIView'애니메이션은 비동기적(asynchrounous)임. 따라서 실제 동시적으로 일어나는 애니메이션들이 언제 완료되는지, 그 시점을 특정하기는 어려움.

//: 1.먼저 UIView의 익스텐션 만들어서 "비동기"디스패치그룹 만들기
// 애니메이션 익스텐션 만들기 (디스패치그룹 아규먼트 필요)
extension UIView {
    static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?) {
        // 비동기 디스패치 그룹: enter(입장), leave(퇴장) 구현
        group.enter()
        animate(withDuration: duration, animations: animations) { (success) in
            completion?(success)
            group.leave()
        }
    }
}

//: 2.뷰 초기설정
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red

let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
box.backgroundColor = UIColor.yellow
view.addSubview(box)

//: 3.디스패치 그룹 생성
let animationGroup = DispatchGroup()

PlaygroundPage.current.liveView = view


//: 4.그룹 애니메이션 메서드 실행
// 애니메이션 비동기적으로 실행
UIView.animate(withDuration: 1, animations: {
    box.center = CGPoint(x: 150, y: 150)
}, group: animationGroup, completion: {
    _ in
    UIView.animate(withDuration: 2, animations: {
        box.transform = CGAffineTransform(rotationAngle: .pi/4)
    }, group: animationGroup, completion: nil)
})

// 애니메이션 비동기적으로 실행
UIView.animate(withDuration: 1, animations: { () -> Void in
    view.backgroundColor = UIColor.blue
}, group: animationGroup, completion: nil)

// 애니메이션이 모두 종료하는 시점에 프린트
animationGroup.notify(queue: DispatchQueue.global()) {
    print("Animations Completed!")
}


//: 5.어시스턴트 에디터 열어서, 뷰 확인하기



sleep(5)
PlaygroundPage.current.finishExecution()


/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
//: [Next](@next)
