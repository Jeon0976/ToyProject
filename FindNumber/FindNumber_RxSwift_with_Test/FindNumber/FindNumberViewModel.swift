//
//  FindNumberModel.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import Foundation

import RxSwift
import RxCocoa

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class FindNumberViewModel: ViewModel {
    
    // 상태 관리를 위한 BehaviorRelay 선언
    private let targetRelay = BehaviorRelay(value: 1)
    private let roundRelay: BehaviorRelay<Int>
    private let bestRecordRelay: BehaviorRelay<Int>
    private let currentRecordRelay: BehaviorRelay<Int>
    private let errorRelay = PublishRelay<MyError>()
    
    private let disposeBag = DisposeBag()
    
    var urlSession: URLSessionProtocol!
    var defaults: UserDefaults!

    struct Input {
        let gameStart: PublishRelay<Void>
        let checkNumber: PublishRelay<Int>
        let resetStage: PublishRelay<Void>
    }
    
    struct Output {
        // target의 output처리는 테스트 용이한 코드를 위해 설정
        let target: Observable<Int>
        let round: Driver<Int>
        let bestRecord: Driver<Int>
        let currentRecord: Driver<Int>
        let error: Driver<MyError>
    }
    
    init(
        urlSession: URLSessionProtocol = URLSession.shared,
        defaults: UserDefaults = UserDefaults.standard
    ) {
        self.urlSession = urlSession
        self.defaults = defaults
        
        // UserDefaults에서 초기 값 로드
        let initialRound = defaults.integer(forKey: "Round")
        roundRelay = BehaviorRelay(value: initialRound == 0 ? 1 : initialRound)
        bestRecordRelay = BehaviorRelay(value: defaults.integer(forKey: "BestRecord"))
        currentRecordRelay = BehaviorRelay(value: defaults.integer(forKey: "CurrentRecord"))
    }
    
    func transform(input: Input) -> Output {
        roundRelay.subscribe { [weak self] value in
            let round = value.element!
            
            self?.defaults.set(
                round,
                forKey: "Round"
            )
        }
        .disposed(by: disposeBag)
        
        bestRecordRelay.subscribe { [weak self] value in
            let bestRecord = value.element!
            
            self?.defaults.set(
                bestRecord,
                forKey: "BestRecord"
            )
        }
        .disposed(by: disposeBag)
        
        currentRecordRelay.subscribe { [weak self] value in
            let currentRecord = value.element!
            
            self?.defaults.set(
                currentRecord,
                forKey: "CurrentRecord"
            )
        }
        .disposed(by: disposeBag)
        
        
        input.gameStart
            .flatMapLatest { [weak self] in
                return self?.getNumber() ?? Observable.just(1)
            }
            .subscribe(onNext: { [weak self] newTarget in
                self?.targetRelay.accept(newTarget)
            }, onError: { [weak self] error in
                if let myError = error as? MyError {
                    self?.errorRelay.accept(myError)
                }
            })
            .disposed(by: disposeBag)
        
        input.checkNumber
            .flatMapLatest { [weak self] number -> Observable<Int> in
                guard let self = self else { return .just(1) }

                return self.processNumber(number)
            }
            .subscribe(onNext: { [weak self] newTarget in
                self?.targetRelay.accept(newTarget)
            })
            .disposed(by: disposeBag)
        
        input.resetStage
            .subscribe(onNext: { [weak self] in
                self?.resetStage()
            })
            .disposed(by: disposeBag)
        
        let target = targetRelay.asObservable()
        let round = roundRelay.asDriver(onErrorJustReturn: 1)
        let bestRecord = bestRecordRelay.asDriver(onErrorJustReturn: 0)
        let currentRecord = currentRecordRelay.asDriver(onErrorJustReturn: 0)
        let error = errorRelay.asDriver(onErrorDriveWith: .empty())
        
        return Output(
            target: target,
            round: round,
            bestRecord: bestRecord,
            currentRecord: currentRecord,
            error: error
        )
    }
    
    private func processNumber(_ number: Int) -> Observable<Int> {
        if number == targetRelay.value {
            return updateGameForCorrectNumber()
        } else {
            resetGameForIncorrectNumber()
            return .empty()
        }
    }
    
    private func updateGameForCorrectNumber() -> Observable<Int> {
        return getNumber()
            .do(onNext: { [weak self] _ in
                self?.updateGameRecords()
            })
            .catch { [weak self] error in
                self?.handleErrorAndReturnEmpty(error) ?? .empty()
            }
    }
    
    private func resetGameForIncorrectNumber() {
        roundRelay.accept(1)
        currentRecordRelay.accept(0)
    }
    
    private func updateGameRecords() {
        let newBestRecord = max(self.bestRecordRelay.value, self.currentRecordRelay.value + 1)
        bestRecordRelay.accept(newBestRecord)
        roundRelay.accept(self.roundRelay.value + 1)
        currentRecordRelay.accept(self.currentRecordRelay.value + 1)
    }
    
    private func handleErrorAndReturnEmpty(_ error: Error) -> Observable<Int> {
        if let myError = error as? MyError {
            errorRelay.accept(myError)
        }
        return .empty()
    }
    
    private func resetStage() {
        roundRelay.accept(1)
        bestRecordRelay.accept(0)
        currentRecordRelay.accept(0)
    }
    
    private func getNumber() -> Observable<Int> {
        guard let url = URL(string: "https://www.randomnumberapi.com/api/v1.0/random?min=1&max=3&count=1") else {
            return Observable.error(MyError.invalidURL)
        }
        
        return urlSession.dataTaskObservable(with: url)
               .observe(on: MainScheduler.instance)
               .flatMap { [weak self] data, response -> Observable<Int> in
                   do {
                       // HTTP 상태 코드 검사
                       guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                           throw MyError.networkError
                       }

                       // JSON 디코딩
                       guard let newTarget = try JSONDecoder().decode([Int].self, from: data).first else {
                           throw MyError.decodingError
                       }
                       print("다음 번호: \(newTarget)")
                       return Observable.just(newTarget)
                   } catch {
                       return Observable.error(self?.handleError(error) ?? .networkError)
                   }
               }
               .catch { [weak self] in
                   Observable.error(self?.handleError($0) ?? .networkError)
               }
    }
    
    private func handleError(_ error: Error) -> MyError {
        if let myError = error as? MyError {
            return myError
        } else if error is DecodingError {
            return .decodingError
        } else {
            return .networkError
        }
    }
}
