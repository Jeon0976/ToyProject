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

// RxSwift는 비동기 데이터를 completion handler로 전달하는 것이 아니라 return 값을 전달하기 위해 만들어진 유틸리티이다.
let disposeBag = DisposeBag()
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

    

    func downloadJson(_ url: String) -> Observable<String?>{
        // 8. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
//        return Observable.create() { emitter in
//            emitter.onNext("Hello")
//            emitter.onNext("World")
//            emitter.onCompleted()
//
//            return Disposables.create()
//        }
        // 8. Observable을 만드는 방법
        // Observable의 생명주기
        // 1. Create
        // 2. Subscribe 되었을 때 실행 됨.
        // 3. onNext
        // ----- 끝 -----
        // 4. onCompleted / onError
        // 5. Disposed
        return Observable.create() { emitter in
            let url = URL(string: url)!
            // URLSession 자체가 다른 쓰레드에서 실행
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                // 데이터가 다 준비가 되면,
                if let data = data, let json = String(data: data, encoding: .utf8) {
//                    DispatchQueue.main.async {
//                        emitter.onNext(json)
//                    }
                    emitter.onNext(json)
                }
                
                // 데이터가 준비가 되지 않는다면,
                // Observable의 끝.
                emitter.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                // 중간에 cancel 하면 task -> cancel
                task.cancel()
            }
        }
        
        
//        return Observable.create() { f in
//            DispatchQueue.global().async {
//                let url = URL(string: url)!
//                let data = try! Data(contentsOf: url)
//                let json = String(data: data, encoding: .utf8)
//
//                DispatchQueue.main.async {
//                    f.onNext(json)
//                    f.onCompleted()
//                    // onCompleted 생성으로 [weak self] 안 해줘도 된다.
//                    // onCompleted를 실행함으로써 순환참조 해결
//                }
//
//            }
//
//            return Disposables.create()
//        }
    }
    
    
    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""

        self.setVisibleWithAnimation(self.activityIndicator, true)
        
        // 데이터 생성만 함
//        let observable = downloadJson(MEMBER_LIST_URL)
        
        // 9. Observable로 오는 데이터를 받아서 처리하는 방법
        // subscribe는 disposable을 return 함
//        let disposable = observable.subscribe { event in
//            switch event {
//            case .next(let json):
//                self.editView.text = json
//                self.setVisibleWithAnimation(self.activityIndicator, false)
//                break
//            case .error(let err):
//                print(err)
//                break
//            case .completed:
//                break
//            }
//        }
//
//        disposable.disposed(by: disposeBag)
        
        // subscribe warning은 return값이 나오는데 사용하지 않았다는 것이니깐
        // .disposed(by: disposeBag) 을 사용하던가
        // 아래 처럼 활용
        // 즉, _는 subscribe의 return 값
        downloadJson(MEMBER_LIST_URL)
        // 사이의 값을 전부 다 print 해줌
            .debug()
        // subscribe가 되면 이때 위에 있는 URLSession 실행 됨.
            .subscribe {  event in
                switch event {
                case .next(let json) :
                    // 8. URLSession 쓰레드는 main 쓰레드가 아니여서 에러 발생
//                    self.editView.text = json
//                    self.setVisibleWithAnimation(self.activityIndicator, false)
                    DispatchQueue.main.async {
                        self.editView.text = json
                        self.setVisibleWithAnimation(self.activityIndicator, false)
                    }
                    print("next")
                    // 7. weak self 없이 순환참조를 막을 수 있는 방법이 있음
                    // closure가 발생하면서 reference count가 증가 했고
                    // closure가 없어지면 reference count가 감소 할 것.
                    // 즉, .completed되거나 .error 가 발생하면 closure가 없어지니 reference count가 감소됨.
                case .completed:
                    print("completed")

                    break
                case .error(_) :
                    print("error")
                    break
                }
            }
            .disposed(by: disposeBag)

        
        // dispose하면 왜 실행이 안되나?
//            .dispose()
        // -> 즉, activityIndicator 실행하고 나서, 내부를 실행하기 전에 dispose로 바로 취소로 인해 동작 안함
//            .disposed(by: disposeBag)
        // 근데 또 disposeBag에 넣어서 사용하면 실행 됨
        
        
        
        // Conclusion
        // 8. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
        // -> downloadJson()
        // 9. Observable로 오는 데이터를 받아서 처리하는 방법
        // -> Subscribe { }
    }
}
