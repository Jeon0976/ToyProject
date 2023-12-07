//
//  URLSessionStub.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping DataTaskCompletionHandler
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

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
    
    func dataTask(
        with url: URL,
        completionHandler completionHandler: @escaping DataTaskCompletionHandler
    ) -> URLSessionDataTask {
        URLSessionDataTaskStub(
          stubbedData: stubbedData,
          stubbedResponse: stubbedResponse,
          stubbedError: stubbedError,
          completionHandler: completionHandler
        )
    }
}

final class URLSessionDataTaskStub: URLSessionDataTask {
    private let stubbedData: Data?
    private let stubbedResponse: URLResponse?
    private let stubbedError: Error?
    private let completionHandler: DataTaskCompletionHandler?

    init(
      stubbedData: Data? = nil,
      stubbedResponse: URLResponse? = nil,
      stubbedError: Error? = nil,
      completionHandler: DataTaskCompletionHandler? = nil
    ) {
      self.stubbedData = stubbedData
      self.stubbedResponse = stubbedResponse
      self.stubbedError = stubbedError
      self.completionHandler = completionHandler
    }

    override func resume() {
        completionHandler?(stubbedData, stubbedResponse, stubbedError)
    }
}
