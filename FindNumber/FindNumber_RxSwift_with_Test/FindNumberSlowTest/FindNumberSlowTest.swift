//
//  FindNumberSlowTest.swift
//  FindNumberSlowTest
//
//  Created by 전성훈 on 2023/12/09.
//

import XCTest

import RxSwift
import RxBlocking

@testable import FindNumber

final class FindNumberSlowTests: XCTestCase {
    var sut: URLSession!
    let networkMonitor = NetworkMonitor.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_유효한API_호출후_HTTPStatusCode200_받기() throws {
        try XCTSkipUnless(networkMonitor.isReachable, "Network connectivity needed for this test.")
        
        // given
        let urlString = "https://www.randomnumberapi.com/api/v1.0/random?min=0&max=3&count=1"
        let url = URL(string: urlString)!
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTaskObservable = sut.dataTaskObservable(with: url)
        do {
            let result = try dataTaskObservable
                .map { $0.urlResponse as? HTTPURLResponse }
                .compactMap { $0?.statusCode }
                .toBlocking(timeout: 3)
                .first()
            
            statusCode = result
        } catch {
            responseError = error
        }

        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
