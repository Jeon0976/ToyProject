//
//  FindNumberViewController.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import UIKit

import RxSwift
import RxCocoa

final class FindNumberViewController: UIViewController {
    
    private var viewModel: FindNumberViewModel!
    private let disposeBag = DisposeBag()
    
    private lazy var stageLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        
        return label
    }()
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        
        label.text = "번호를 맞춰주세요"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        button.setTitle("1번", for: .normal)
        button.tag = 1
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        button.setTitle("2번", for: .normal)
        button.tag = 2
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        button.setTitle("다시 시작", for: .normal)
        
        return button
    }()
    
    private lazy var bestRecordLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    private lazy var currentRecordLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FindNumberViewModel()
        
        setLayout()
        bindData()
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        
        [
            firstButton,
            secondButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.addArrangedSubview($0)
        }
        
        [
            stageLabel,
            explanationLabel,
            buttonStackView,
            resetButton,
            bestRecordLabel,
            currentRecordLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stageLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            explanationLabel.topAnchor.constraint(equalTo: stageLabel.bottomAnchor, constant: 16),
            explanationLabel.centerXAnchor.constraint(equalTo: stageLabel.centerXAnchor),
            
            buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -36),
            
            resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            
            bestRecordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            bestRecordLabel.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: 36),
            
            currentRecordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            currentRecordLabel.topAnchor.constraint(equalTo: bestRecordLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func bindData() {
        let input = FindNumberViewModel.Input(
            gameStart: PublishRelay<Void>(),
            checkNumber: PublishRelay<Int>(),
            resetStage: PublishRelay<Void>()
        )
        
        self.rx.viewDidLoad
            .map { _ in }
            .bind(to: input.gameStart)
            .disposed(by: disposeBag)
        
        firstButton.rx.tap
            .map { 1 }
            .bind(to: input.checkNumber)
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .map { 2 }
            .bind(to: input.checkNumber)
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .bind(to: input.resetStage)
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(input: input)
        
        output.round
            .map { "스테이지: \($0)"}
            .drive(stageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.bestRecord
            .map { "최대: \($0)번 연속 성공!"}
            .drive(bestRecordLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.currentRecord
            .map { "현재: \($0)번 연속 성공!"}
            .drive(currentRecordLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                self?.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "에러",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "확인",
                style: .default,
                handler: nil
            )
        )
        
        self.present(alert, animated: true)
    }
}

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
}
