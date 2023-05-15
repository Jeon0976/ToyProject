//
//  SignUpDetailViewController.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

final class SignUpDetailViewController: UIViewController {
    //MARK: Property
    var phoneNumberLabel = UILabel()
    var phoneNumberField = UITextField()
    
    var birthLabel = UILabel()
    var selectedBirthLabel = UILabel()
    var datePicker = UIDatePicker()
    
    var cancelButton = UIButton()
    var beforeButton = UIButton()
    var fixedButton = UIButton()
    
    var buttonStack = UIStackView()
    
    var tapGesture = UITapGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkAllValue()
    }
    
    //MARK: Attribute
    private func attribute() {
        view.backgroundColor = .systemBackground
        
        phoneNumberLabel.text = "전화번호"
    
        phoneNumberField.keyboardType = .numberPad
        phoneNumberField.borderStyle = .roundedRect
        phoneNumberField.delegate = self
        
        birthLabel.text = "생년월일"
                
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePicked(_:)), for: .valueChanged)
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        
        beforeButton.setTitle("이전", for: .normal)
        beforeButton.setTitleColor(.systemBlue, for: .normal)
        beforeButton.addTarget(self, action: #selector(tapBeforeButton), for: .touchUpInside)
        
        fixedButton.setTitle("가입", for: .normal)
        fixedButton.setTitleColor(.systemBlue, for: .normal)
        fixedButton.setTitleColor(.systemGray, for: .disabled)
        fixedButton.addTarget(self, action: #selector(tapFixedButton), for: .touchUpInside)
        fixedButton.isEnabled = false
        
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: Layout
    private func layout() {
        [
            cancelButton,
            beforeButton,
            fixedButton
        ].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
        
        [
            phoneNumberLabel,
            phoneNumberField,
            birthLabel,
            selectedBirthLabel,
            datePicker,
            buttonStack
        ].forEach {
            view.addSubview($0)
        }
        
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedBirthLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 16),
            phoneNumberField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            birthLabel.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 16),
            birthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            selectedBirthLabel.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 16),
            selectedBirthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: birthLabel.bottomAnchor, constant: 16),
            buttonStack.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    //MARK: fixed Button 조건 확인 함수
    func checkAllCondition() {
        guard phoneNumberField.text != nil
//              selectedBirthLabel.text != nil
        else {
            fixedButton.isEnabled = false
            return
        }
        
        fixedButton.isEnabled = true
    }
    
    //MARK: @objc
    @objc func datePicked(_ sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let dateString = dateFormatter.string(from: date)
        
        selectedBirthLabel.text = dateString
        
        checkAllCondition()
    }
    
    @objc func tapCancelButton() {
        UserInformation.shared.allClear()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func tapBeforeButton() {
        UserInformation.shared.birthDate = selectedBirthLabel.text
        UserInformation.shared.phoneNumber = phoneNumberField.text
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tapFixedButton() {
        UserInformation.shared.birthDate = selectedBirthLabel.text
        UserInformation.shared.phoneNumber = phoneNumberField.text
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: UserInformation value   확인
    private func checkAllValue() {
        phoneNumberField.text = UserInformation.shared.phoneNumber ?? nil
        selectedBirthLabel.text = UserInformation.shared.birthDate ?? nil
    }
}

//MARK: UITextFieldDelegate
extension SignUpDetailViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkAllCondition()
    }
}

//MARK: UIGestureRecognizerDelegate
extension SignUpDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        
        return true
    }
}
