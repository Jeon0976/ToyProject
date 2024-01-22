//
//  FindNumberTests.swift
//  FindNumberTests
//
//  Created by 전성훈 on 2023/12/08.
//

import XCTest

import RxSwift
import RxCocoa
import RxTest

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
    
    var sut: FindNumberViewModel!
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let urlSessionStub = URLSessionStub()
        let mockUserDefaults = MockUserDefaults(suiteName: "TestDefaults")
        
        sut = FindNumberViewModel(
            urlSession: urlSessionStub,
            defaults: mockUserDefaults!
        )
        
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        scheduler = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func test_게임시작() {
        // given
        let stubbedData = "[2]".data(using: .utf8)
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
        
        // 게임 시작 이벤트를 시뮬레이션하기 위한 PublishRelay 생성
        let gameStart = PublishRelay<Void>()
        
        // ViewModel의 Input 구조체 생성
        let input = FindNumberViewModel.Input(
            gameStart: gameStart,
            checkNumber: PublishRelay<Int>(),
            resetStage: PublishRelay<Void>())
        
        // ViewModel의 Output을 받기 위한 변수 선언
        let output = sut.transform(input: input)
        
        // Output에서 round 값을 관찰하기 위한 Observer 생성
        let targetObserver = scheduler.createObserver(Int.self)
        let roundObserver = scheduler.createObserver(Int.self)
        
        // when
        scheduler.scheduleAt(0) {
            output.target
                .bind(to: targetObserver)
                .disposed(by: self.disposeBag)
            
            output.round
                .drive(roundObserver)
                .disposed(by: self.disposeBag)
        }
        
        scheduler.scheduleAt(10) {
            gameStart.accept(())
        }
        
        scheduler.start()
        
        // then
        XCTAssertEqual(targetObserver.events, [
            .next(0, 1),
            .next(10, 2)]
        )
        
        XCTAssertEqual(roundObserver.events, [.next(0, 1)])
    }
    
    func test_스테이지_진행() {
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
        
        let checkNumber = PublishRelay<Int>()
        
        let input = FindNumberViewModel.Input(
            gameStart: PublishRelay<Void>(),
            checkNumber: checkNumber,
            resetStage: PublishRelay<Void>()
        )
        
        let output = sut.transform(input: input)
        
        let targetObserver = scheduler.createObserver(Int.self)
        let roundObserver = scheduler.createObserver(Int.self)
        let bestRecordObserver = scheduler.createObserver(Int.self)
        let currentRecordObserver = scheduler.createObserver(Int.self)
        
        // when
        scheduler.scheduleAt(0) {
            output.target
                .bind(to: targetObserver)
                .disposed(by: self.disposeBag)
            
            output.round
                .drive(roundObserver)
                .disposed(by: self.disposeBag)
            
            output.bestRecord
                .drive(bestRecordObserver)
                .disposed(by: self.disposeBag)
            
            output.currentRecord
                .drive(currentRecordObserver)
                .disposed(by: self.disposeBag)
        }
        
        
        scheduler.scheduleAt(10) {
            checkNumber.accept(1)
        }
        
        scheduler.scheduleAt(15) {
            checkNumber.accept(1)
        }
        
        scheduler.scheduleAt(20) {
            checkNumber.accept(1)
        }
        
        scheduler.scheduleAt(25) {
            checkNumber.accept(2)
        }
        
        scheduler.scheduleAt(30) {
            checkNumber.accept(1)
        }
        
        scheduler.start()
        
        // then
        XCTAssertEqual(targetObserver.events, [
            .next(0, 1),
            .next(10, 1),
            .next(15, 1),
            .next(20, 1),
            // 해당 테스트를 통해 틀렸을 때 api 호출은 안한다는것을 알게되었음
            //            .next(0, 1),
            .next(30, 1)
        ])
        
        XCTAssertEqual(roundObserver.events, [
            .next(0, 1),
            .next(10, 2),
            .next(15, 3),
            .next(20, 4),
            .next(25, 1),
            .next(30, 2)]
        )
        XCTAssertEqual(bestRecordObserver.events, [
            .next(0, 0),
            .next(10, 1),
            .next(15, 2),
            .next(20, 3),
            .next(30, 3)]
        )
        
        XCTAssertEqual(currentRecordObserver.events, [
            .next(0, 0),
            .next(10, 1),
            .next(15, 2),
            .next(20, 3),
            .next(25, 0),
            .next(30, 1)]
        )
    }
    
    func test_스테이지_초기화() {
        // given
        let resetStage = PublishRelay<Void>()
        
        let input = FindNumberViewModel.Input(
            gameStart:  PublishRelay<Void>(),
            checkNumber: PublishRelay<Int>(),
            resetStage: resetStage
        )
        
        let output = sut.transform(input: input)
        
        let roundObserver = scheduler.createObserver(Int.self)
        let bestRecordObserver = scheduler.createObserver(Int.self)
        let currentRecordObserver = scheduler.createObserver(Int.self)
        
        output.round
            .drive(roundObserver)
            .disposed(by: disposeBag)
        
        output.bestRecord
            .drive(bestRecordObserver)
            .disposed(by: disposeBag)
        
        output.currentRecord
            .drive(currentRecordObserver)
            .disposed(by: disposeBag)
        
        // when 
        scheduler.createColdObservable([.next(10, 4)])
            .asDriver(onErrorJustReturn: 0)
            .drive(roundObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, 5)])
            .asDriver(onErrorJustReturn: 0)
            .drive(bestRecordObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, 3)])
            .asDriver(onErrorJustReturn: 0)
            .drive(currentRecordObserver)
            .disposed(by: disposeBag)
        
        // 스테이지 초기화
        scheduler.scheduleAt(20) {
            resetStage.accept(())
        }
        
        scheduler.start()
        
        
        // then
        XCTAssertEqual(roundObserver.events, [
            .next(0, 1),
            .next(10, 4),
            .next(20, 1)]
        )
        XCTAssertEqual(bestRecordObserver.events, [
            .next(0, 0),
            .next(10, 5),
            .next(20, 0)]
        )
        XCTAssertEqual(currentRecordObserver.events, [
            .next(0, 0),
            .next(10, 3),
            .next(20, 0)]
        )
    }
    
    func test_checkNumber_네트워크_오류_발생() {
        // given
        // 네트워크 요청 실패를 시뮬레이션하기 위해 URLSessionStub 구성
        let urlSessionStub = URLSessionStub(
            stubbedData: nil,
            stubbedResponse: nil,
            stubbedError: MyError.networkError
        )
        
        sut.urlSession = urlSessionStub
        
        let errorObserver = scheduler.createObserver(MyError.self)
        
        // ViewModel의 Input 구조체 생성
        let input = FindNumberViewModel.Input(
            gameStart: PublishRelay<Void>(),
            checkNumber: PublishRelay<Int>(),
            resetStage: PublishRelay<Void>()
        )
        
        // ViewModel의 Output을 받기 위한 변수 선언
        let output = sut.transform(input: input)
        
        // when
        // Output에서 error 값을 관찰하기 위한 Observer 생성
        output.error
            .drive(errorObserver)
            .disposed(by: disposeBag)
        
        // 게임 시작 이벤트 발생
        input.checkNumber.accept(1)
        
        // then
        // 오류 발생 검증
        XCTAssertEqual(errorObserver.events, [.next(0, MyError.networkError)])
    }
    
    func test_gameStart_디코딩_오류() {
        // given
        // 디코딩 오류를 시뮬레이션하기 위해 잘못된 형식의 데이터를 설정
        let invalidData = "[d]".data(using: .utf8)!
        
        let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=1&max=3&count=1"
        let url = URL(string: urlString)!
        let stubbedResponse = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let urlSessionStub = URLSessionStub(
            stubbedData: invalidData,
            stubbedResponse: stubbedResponse,
            stubbedError: nil
        )
        
        sut.urlSession = urlSessionStub
        
        // ViewModel의 Input 구조체 생성
        let input = FindNumberViewModel.Input(
            gameStart: PublishRelay<Void>(),
            checkNumber: PublishRelay<Int>(),
            resetStage: PublishRelay<Void>()
        )
        
        let errorObserver = scheduler.createObserver(MyError.self)
        
        // ViewModel의 Output을 받기 위한 변수 선언
        let output = sut.transform(input: input)
        
        // when
        // Output에서 error 값을 관찰하기 위한 Observer 생성
        scheduler.scheduleAt(0) {
            output.error
                .drive(errorObserver)
                .disposed(by: self.disposeBag)
        }
        
        scheduler.start()
        
        // 게임 시작 이벤트 발생
        input.gameStart.accept(())
        
        // then
        XCTAssertEqual(errorObserver.events, [.next(0, MyError.decodingError)])
    }
}

