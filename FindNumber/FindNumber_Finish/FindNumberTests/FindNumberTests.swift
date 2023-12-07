//
//  FindNumberTests.swift
//  FindNumberTests
//
//  Created by 전성훈 on 2023/12/06.
//

import XCTest

@testable import FindNumber

final class MockUserDefaults: UserDefaults {
    private var storage = [String: Any]()

    override func integer(forKey defaultName: String) -> Int {
        return storage[defaultName] as? Int ?? 0
    }

    override func set(_ value: Int, forKey defaultName: String) {
        storage[defaultName] = value
    }
}

final class FindNumberTests: XCTestCase {
    var sut: FindNumberModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let urlSessionStub = URLSessionStub()
        let mockUserDefaults = MockUserDefaults(suiteName: "TestDefaults")

        sut = FindNumberModel(
            urlSession: urlSessionStub,
            defaults: mockUserDefaults!
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_타겟번호_받기() {
        // given
        let stubbedData = "[1]".data(using: .utf8)
        let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=1&max=3&count=1"
        let url = URL(string: urlString)!
        let stubbedResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let urlSessionStub = URLSessionStub(
            stubbedData: stubbedData,
            stubbedResponse: stubbedResponse,
            stubbedError: nil
        )
        
        sut.urlSession = urlSessionStub
        
        // when
        var receivedNumber: Int?
        sut.getNumber { number in
            receivedNumber = number
        }
        
        // then
        XCTAssertEqual(receivedNumber, 1)
    }
    
    func test_사용자_선택번호와_타겟이_같을_경우() {
        // given
        sut.target = 1
        let expectedValue = sut.target
        
        // when
        sut.checkNum(value: expectedValue)
        
        // then
        XCTAssertEqual(sut.currentRecord, 1, "Current record should be incremented")
        XCTAssertEqual(sut.bestRecord, 1, "Best record should be incremented")
        XCTAssertEqual(sut.round, 2, "Rount should be incremented")
    }
    
    func test_사용자_선택번호와_타겟이_다를_경우() {
        // given
        sut.target = 2
        let expectedValue = 1
        
        // when
        sut.checkNum(value: expectedValue)
        
        // then
        XCTAssertEqual(sut.currentRecord, 0, "Current record should be reset to 0")
        XCTAssertEqual(sut.round, 1, "Round should be reset to 1")
    }
    
    func test_스테이지_초기화() {
        // given
        sut.round = 3
        sut.currentRecord = 2
        sut.bestRecord = 5
        
        // when
        sut.resetStage()
        
        // then
        XCTAssertEqual(
            sut.round,
            1,
            "Round should be reset to 1"
        )
        XCTAssertEqual(
            sut.currentRecord,
            0,
            "Current record should be reset to 0"
        )
        XCTAssertEqual(
            sut.bestRecord,
            0,
            "Best record should be reset to 0"
        )
    }
}
