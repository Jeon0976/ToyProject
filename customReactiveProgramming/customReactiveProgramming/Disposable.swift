//
//  Disposable.swift
//  customReactiveProgramming
//
//  Created by 전성훈 on 2023/11/02.
//

import Foundation

private final class Disposables {
    private var disposables: [() -> Void] = [] {
        didSet {
            print(disposables)
        }
    }
    
    func add(_ disposable: @escaping () -> Void) {
        disposables.append(disposable)
    }
    
    func dispose() {
        disposables.forEach { $0() }
        disposables.removeAll()
    }
}

final class DisposeBag {
    private let disposables = Disposables()
    
    func add(_ disposable: @escaping () -> Void) {
        disposables.add(disposable)
    }
    
    func clear() {
        disposables.dispose()
    }
    
    deinit {
        disposables.dispose()
    }
}
