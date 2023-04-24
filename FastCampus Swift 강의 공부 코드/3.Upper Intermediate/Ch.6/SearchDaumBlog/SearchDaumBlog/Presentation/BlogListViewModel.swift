//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/11/04.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    // BlogListView가 FilterView를 해더로 사용하기 때문에 BlogListViewModel이 FilterViewModel를 갖고 있음
    let filterViewModel = FilterViewModel()
    
    // MainViewController -> BlogListView
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
