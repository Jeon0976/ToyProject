//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

// 1
// 최초 Load 버튼 눌렀을 때 JSon을 다운 받고 있어서 인티게이터가 안보이고 시간이 멈춤
// 비동기로 돌려야 함

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

// 6
// 나중에생기는데이터
class 나중에생기는데이터<T> {
    private let task: (@escaping (T) -> Void) -> Void
    
    init(task: @escaping (@escaping (T) -> Void) -> Void) {
        self.task = task
    }
    
    func 나중에오면(_ f: @escaping (T) -> Void) {
        task(f)
    }
}


class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }

    
    // 3
//    func downloadJson(_ url: String) -> String?{
//        // 기존 버튼 클릭 함수를 깔끔하게 하기 위해 여기서 DispatchQueue 처리
//        // 왜냐면 이 기능만 DispatchQueue를 필요로 하니깐
//        DispatchQueue.global().async {
//            let url = URL(string: url)!
//            let data = try! Data(contentsOf: url)
//            let json = String(data: data, encoding: .utf8)
//
//            // 이렇게 코드를 만들면 return을 활용 못하기 때문에 Completion 클로저 활용
//            return json
//        }
//    }
    // 4
    // json을 함수 밖에서 실행되야 하니깐 escaping completion
    // 만약 completion이 옵셔널일 경우 escaping이 default 값임
//    func downloadJson(_ url: String, _ completion: @escaping (String?) -> Void){
//        // 기존 버튼 클릭 함수를 깔끔하게 하기 위해 여기서 DispatchQueue 처리
//        // 왜냐면 이 기능만 DispatchQueue를 필요로 하니깐
//        DispatchQueue.global().async {
//            let url = URL(string: url)!
//            let data = try! Data(contentsOf: url)
//            let json = String(data: data, encoding: .utf8)
//
//            // 이렇게 코드를 만들면 return을 활용 못하기 때문에 Completion 클로저 활용
//            DispatchQueue.main.async {
//                completion(json)
//            }
//        }
//    }
    
    // 6
    // 결국 return 값을 completion으로 하는 것이 아니라 값으로 return 하는 방법은 없을까?
    // 즉, 비동기로 생기는 데이터를 어떻게 리턴값으로 만들까? 고민에서 만들어진것
    // 사용하기 편하게
    func downloadJson(_ url: String) -> 나중에생기는데이터<String?>{
        return 나중에생기는데이터() { f in
            DispatchQueue.global().async {
                let url = URL(string: url)!
                let data = try! Data(contentsOf: url)
                let json = String(data: data, encoding: .utf8)

                DispatchQueue.main.async {
                    f(json)
                }
            }
        }
    }
    
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""

        self.setVisibleWithAnimation(self.activityIndicator, true)
        
//        self.downloadJson(MEMBER_LIST_URL) { json in
//            self.editView.text = json
//            self.setVisibleWithAnimation(self.activityIndicator, false)
//
//
//            // 5
//            // 만약 같은 함수를 여러번 반복 실행하려면 어떻게 해야할까
//            // 클로저로 되어있으니 함수 안에 함수를 실행하는 방식으로 코드를 만들어야 하나
//            // 다운로드 뿐만 아니라 엮여서 진행하는 다른 함수들을 호출해야 한다면 이렇게 호출해야 한다.
//            // 중간에 에러가 나면 처리하는 작업이 너무 힘들어짐.
////            self.downloadJson(MEMBER_LIST_URL) { json in
////                self.editView.text = json
////                self.setVisibleWithAnimation(self.activityIndicator, false)
////
////                self.downloadJson(MEMBER_LIST_URL) { json in
////                    self.editView.text = json
////                    self.setVisibleWithAnimation(self.activityIndicator, false)
////
////                    self.downloadJson(MEMBER_LIST_URL) { json in
////                        self.editView.text = json
////                        self.setVisibleWithAnimation(self.activityIndicator, false)
////                    }
////                }
////            }
//        }
        
    // 2
    // 비동기 작업을 위한 dispatchQueue
    // 그리고 Button 클릭 함수 내부에 dispatchQueue을 만들지 않고 별도 함수를 만들어서 그 함수에 DispatchQueue 생성
//        DispatchQueue.global().async {
//
//            let json = self.downloadJson(MEMBER_LIST_URL)
//
//            DispatchQueue.main.async {
//                self.editView.text = json
//                self.setVisibleWithAnimation(self.activityIndicator, false)
//            }
//        }
//
        
        // 6
        // completion을 활용하지 않고 return 값으로 처리
        let json:나중에생기는데이터<String?> = downloadJson(MEMBER_LIST_URL)
        
        json.나중에오면 { json in
            self.editView.text = json
            self.setVisibleWithAnimation(self.activityIndicator, false)
        }
    }
}
