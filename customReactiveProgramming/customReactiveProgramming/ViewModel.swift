//
//  ViewModel.swift
//  customReactiveProgramming
//
//  Created by 전성훈 on 2023/11/02.
//

import Foundation

protocol MainViewModelInput {
    func viewDidLoad()
    func textDidChange(text: String?)
}

protocol MainViewModelOutput {
    var textFieldText: Observable<String?> { get }
}

typealias MainViewModelProtocol = MainViewModelInput & MainViewModelOutput

final class MainViewModel: MainViewModelProtocol {
    
    // MARK: Output
    // Observable 생성
    let textFieldText: Observable<String?> = Observable(nil)
}

// MARK: Input
extension MainViewModel {
    func viewDidLoad() {
        
    }
    
    func textDidChange(text: String?) {
        textFieldText.value = text
    }
}
