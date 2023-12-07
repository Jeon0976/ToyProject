//
//  FindNumberTests.swift
//  FindNumberTests
//
//  Created by 전성훈 on 2023/12/06.
//

import XCTest

@testable import FindNumber

final class FindNumberTests: XCTestCase {
    var sut: FindNumberModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = FindNumberModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetNumber() {
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
    
    func testCheckNum_Success() {
        // given
        sut.target = 1
        
        let expectedValue = sut.target
        
        // when
        sut.checkNum(value: expectedValue)
        
        // then
        XCTAssertEqual(sut.currentRecord, 1, "Current record should be incremented")
    }
    
    func testCheckNum_Failure() {
        // given
        sut.target = 2
        let expectedValue = 1
        
        // when
        sut.checkNum(value: expectedValue)
        
        // then
        XCTAssertEqual(sut.currentRecord, 0, "Current record should be reset to 0")
        XCTAssertEqual(sut.round, 1, "Round should be reset to 1")
    }
    
    func testResetStage() {
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
