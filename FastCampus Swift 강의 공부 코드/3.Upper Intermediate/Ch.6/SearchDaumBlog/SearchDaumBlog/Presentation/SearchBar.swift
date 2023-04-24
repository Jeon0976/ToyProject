//
//  searchBar.swift
//  SearchDaumBlog
//
//  Created by 전성훈 on 2022/10/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
//    // SearchBar Button Tap Event
//    let searchButtonTapped = PublishRelay<Void>()
//
//    // External SearchBar Event
//    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 내부 init에서 bind를 없에는 이유는 외부에서 직접 실행할 것이기 때문???
 func bind(_ viewModel : SearchBarViewModel) {
        
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        // searchBar Search Button tapped
        // button Tapped
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)

//        // View가 직접적으로 알 필요가 없는 로직
//        self.shouldLoadResult = searchButtonTapped
//            .withLatestFrom(self.rx.text) { $1 ?? "" }
//            .filter{ !$0.isEmpty }
//            .distinctUntilChanged()
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}


extension Reactive where Base : SearchBar {
    var endEditing : Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
