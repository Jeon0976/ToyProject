//
//  ViewModel.swift
//  UsedGoodsUpload
//
//  Created by 전성훈 on 2022/11/04.
//

import UIKit

import RxSwift
import RxCocoa

struct MainViewModel {
    let titleTextFieldCellViewModel = TitleTextFieldCellViewModel()
    let priceTextFieldCellViewModel = PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    // ViewModel -> View
    let cellData : Driver<[String]>
    let presentAlert : Signal<Alert>
    let push: Driver<CategoryViewModel>
    
    // View -> ViewModel
    // itemSelected는 카테고리를 클릭할 때 나올 이벤트
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()

    

    init(model: MainModel = MainModel()) {
        let title = Observable.just("글 제목")
        let categoryViewModel = CategoryViewModel()
        // 카테고리에서 선택된 것을 selectedCateogry로 연결
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name }
            .startWith("카테고리 선택")
        let price = Observable.just("￦ 가격 (선택사항)")
        let detail = Observable.just("내용을 입력하세요.")
        
        self.cellData = Observable
            .combineLatest(title,
                           category,
                           price,
                           detail
            ) { [$0,$1,$2,$3] } // array로 묶여서 전달 됨
            .asDriver(onErrorJustReturn: []) // 만약 에러 발생시 빈 array
        
        let titleMessage = titleTextFieldCellViewModel
            .titleText
            .map{ $0?.isEmpty ?? true }
            .startWith(true)
            .map{ $0 ? ["- 글 제목을 입력해주세요."]:[]}
        
        let categoryMessage = categoryViewModel
            .selectedCategory
            .map { _ in false }
            .startWith(true)
            .map{ $0 ? ["- 카테고리를 선택해주세요."]:[]}
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map{ $0 ? ["- 내용을 선택해주세요."]:[]}
        
        let errorMessage = Observable
            .combineLatest(titleMessage, categoryMessage, detailMessage) {$0 + $1 + $2}
        
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessage)
            .map (model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        // itemSelected로 받은 row값을 guard case로 조건문 생성
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in
                guard case 1 = row else { return nil }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
