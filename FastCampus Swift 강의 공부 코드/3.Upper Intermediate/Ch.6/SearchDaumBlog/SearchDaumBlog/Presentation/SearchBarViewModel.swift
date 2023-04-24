//
//  SearchBarViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/11/04.
//

import RxSwift
import RxCocoa

// 주로 bind에 있는 코드들이 ViewModel로 옮겨짐
// View가 직접적으로 알 필요가 없는 로직
struct SearchBarViewModel {
    // self.rx.text를 받을 Observable 생성
    let queryText = PublishRelay<String?>()
    
    let searchButtonTapped = PublishRelay<Void>()
    let shouldLoadResult: Observable<String>
    
    init() {
        // self.rx.text -> View가 갖고있는 값 ViewModel이 self를 알지못함
        // 따라서 그러한 형태의 String을 전달해주기만 하면 됨
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(queryText) { $1 ?? "" }
            .filter{ !$0.isEmpty }
            .distinctUntilChanged()
    }
}
