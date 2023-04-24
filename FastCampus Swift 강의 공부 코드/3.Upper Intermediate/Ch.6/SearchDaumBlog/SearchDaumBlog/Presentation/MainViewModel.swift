//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/11/04.
//
import UIKit
import RxSwift
import RxCocoa


struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()

    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel() ) {
        //네트워크 로직
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        // 네트워크를 통해 가져온 값을 celldata로 변환
        let cellData = blogValue
            .map(model.getBlogListCellData)
        
        // FilterView를 선택했을 때 나오는 alertsheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime :
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        // MainViewController -> ListView
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort
            )
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)

        // signal로 viewmodel에서 View로 전달
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title : "Sort" , message : nil, actions: [.title, .datetime, .cancel], style : .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title : "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style :.alert
                )
            }
        
        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
