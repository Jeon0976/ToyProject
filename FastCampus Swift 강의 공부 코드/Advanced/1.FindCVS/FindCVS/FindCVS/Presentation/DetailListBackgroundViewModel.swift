//
//  DetailListBackgroundViewModel.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/14.
//

import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
    // viewModel -> View
    let isStatusLabelHidden: Signal<Bool>
    
    // 외부에서 전달 받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
