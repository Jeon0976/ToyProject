//
//  ViewController.swift
//  FindNumber
//
//  Created by 전성훈 on 2023/12/06.
//

import UIKit

class ViewController: UIViewController {
    
    private var model: FindNumberModel!
    
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
        button.addTarget(self, action: #selector(checkNum(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(configuration: .filled())
        
        button.setTitle("2번", for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(checkNum(_:)), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(resetStage(_:)), for: .touchUpInside)
        
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
        
        model = FindNumberModel()
        setLayout()
        bindData()
        
        updateUI()
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
        model.onUpdate = { [weak self] in
            self?.updateUI()
        }
        model.onError = { [weak self] message in
            self?.showError(message)
        }
    }
    
    private func updateUI() {
        stageLabel.text = "스테이지: \(model.round)"
        bestRecordLabel.text = "최대: \(model.bestRecord)번 연속 성공!"
        currentRecordLabel.text = "현재: \(model.currentRecord)번 연속 성공!"
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc private func checkNum(_ sender: UIButton) {
        model.checkNum(value: sender.tag)
    }
    
    @objc private func resetStage(_ sender: UIButton) {
        model.resetStage()
    }
}

