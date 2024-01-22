//
//  URLSessionStub.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import Foundation

import RxSwift

enum MyError: Error {
    case invalidURL
    case networkError
    case decodingError
}

typealias ResultData = (data: Data, urlResponse: URLResponse)

protocol URLSessionProtocol {
    func dataTaskObservable(with url: URL) -> Observable<ResultData>
}

extension URLSession: URLSessionProtocol {
    func dataTaskObservable(with url: URL) -> Observable<ResultData> {
        return Observable.create { [weak self] observer in
            let task = self?.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data, let response = response {
                    let result = ResultData(data, response)
                    
                    observer.onNext(result)
                } else {
                    observer.onError(MyError.networkError)
                }
                
                observer.onCompleted()
            }
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

final class URLSessionStub: URLSessionProtocol {
    private let stubbedData: Data?
    private let stubbedResponse: URLResponse?
    private let stubbedError: Error?
    
    init(
        stubbedData: Data? = nil,
        stubbedResponse: URLResponse? = nil,
        stubbedError: Error? = nil
    ) {
        self.stubbedData = stubbedData
        self.stubbedResponse = stubbedResponse
        self.stubbedError = stubbedError
    }
    
    func dataTaskObservable(with url: URL) -> Observable<ResultData> {
        return Observable.create { [weak self] observer in
            if let error = self?.stubbedError {
                observer.onError(error)
            } else if let data = self?.stubbedData, let response = self?.stubbedResponse {
                let result = ResultData(data, response)
                
                observer.onNext(result)
            }
            else {
                observer.onError(MyError.networkError)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
