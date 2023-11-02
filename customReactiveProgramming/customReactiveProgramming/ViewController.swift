//
//  ViewController.swift
//  customReactiveProgramming
//
//  Created by 전성훈 on 2023/11/02.
//

import UIKit

final class MainViewController: UIViewController, Alertable {
    
    private var viewModel: MainViewModelProtocol? = MainViewModel()
    
    private let textField = UITextField()
    private let label = UILabel()
    private let button = UIButton()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        label.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [textField, label])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16)
        ])
        button.setTitle("disposeBag", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(cancelSubscribe), for: .touchUpInside)
    }
    
    // MARK: Input
    @objc private func textFieldDidChange() {
        viewModel?.textDidChange(text: textField.text)
    }
    
    @objc private func cancelSubscribe() {
        button.isSelected.toggle()
        if button.isSelected {
            disposeBag.clear()
            viewModel = nil
        } else {
            viewModel = MainViewModel()
            bindViewModel()
            
        }

    }
    
    // MARK: Output
    private func bindViewModel() {
        viewModel?.textFieldText
            .subscribe(on: self, disposeBag: disposeBag)
            .onNext { [weak self] text in
                if let text = text {
                    self?.label.text = text + "\n" + text
                }
            }
        
        viewModel?.textFieldText
            .subscribe(on: self, disposeBag: disposeBag)
            .onNext { text in
                if let text = text {
                    print(text)
                }
            }
    }
}

#if DEBUG

import SwiftUI

struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewController = MainViewController()
        return viewController.toPreView()
    }
}
#endif
