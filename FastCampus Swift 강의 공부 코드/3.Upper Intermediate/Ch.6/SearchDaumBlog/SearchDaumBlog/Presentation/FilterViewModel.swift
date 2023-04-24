//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/11/04.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
