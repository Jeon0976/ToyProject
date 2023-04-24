//
//  MainModel.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/11/04.
//

import UIKit
import RxSwift


// network 로직 자체는 viewModel에서 처리할 일이라고 보기 어려움
struct MainModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DKBlog,SearchNetworkError>> {
        return network.searchBlog(query: query)
    }
    
    func getBlogValue(_ result: Result<DKBlog,SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog,SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: DKBlog) -> [BlogListCellData] {
        return value.documents
            .map { doc in
                let thumbnailURL = URL(string: doc.thumbnail ?? "")
                return BlogListCellData (
                thumbnailURL: thumbnailURL,
                name: doc.name,
                title: doc.title,
                dateTime: doc.datetime
                )
            }
    }
    
    func sort(by type: MainViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? ""}
        case .datetime:
            return data.sorted { $0.dateTime ?? Date() > $1.dateTime ?? Date() }
        default :
            return data
        }
    }
}
