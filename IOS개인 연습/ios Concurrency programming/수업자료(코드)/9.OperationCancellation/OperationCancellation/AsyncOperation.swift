//
//  AsyncOperation.swift
//  OperationCancellation
//
//  Created by Allen on 2020/02/08.
//  Copyright © 2020 allen. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        // KVO notifications을 위한 keyPath설정
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    
    // 직접 관리하기 위한 상태 변수 생성
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }

    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
}
