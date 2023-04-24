//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 전성훈 on 2022/11/04.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
