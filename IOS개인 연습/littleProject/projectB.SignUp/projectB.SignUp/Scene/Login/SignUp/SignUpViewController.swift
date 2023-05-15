//
//  SignUpViewController.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

final class SignUpViewController: UIViewController {
    //MARK: Property
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        return picker
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    var idTextField = UITextField()
    var passwordTextField = UITextField()
    var checkPassWordTextField = UITextField()
    
    var selfIntroduction = UITextView()
    
    var cancelButton = UIButton()
    var checkButton = UIButton()
    
    var textFieldStackView = UIStackView()
    var topStackView = UIStackView()
    var buttonStackView = UIStackView()
    
    var tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        checkAllValue()
    }
    
    //MARK: Attribute
    private func setUpAttribute() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
                
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        idTextField.clearButtonMode = .always
        idTextField.backgroundColor = .secondarySystemBackground
        idTextField.delegate = self
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clearButtonMode = .always
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        checkPassWordTextField.placeholder = "Password"
        checkPassWordTextField.borderStyle = .roundedRect
        checkPassWordTextField.clearButtonMode = .always
        checkPassWordTextField.backgroundColor = .secondarySystemBackground
        checkPassWordTextField.isSecureTextEntry = true
        checkPassWordTextField.delegate = self
        
        selfIntroduction.backgroundColor = .systemGray
        selfIntroduction.delegate = self
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(popSignUpView), for: .touchUpInside)
        
        
        checkButton.setTitle("다음", for: .normal)
        checkButton.setTitleColor(.systemBlue, for: .normal)
        checkButton.setTitleColor(.systemGray, for: .disabled)
        checkButton.addTarget(self, action: #selector(pushDetailSignView), for: .touchUpInside)
        checkButton.isEnabled = false
        
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 12
        textFieldStackView.distribution = .fillEqually

        
        topStackView.axis = .horizontal
        topStackView.spacing = 12
        
    
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 12
        buttonStackView.distribution = .fillEqually
        
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: Layout
    private func setUpLayout() {
        
        [
            idTextField,
            passwordTextField,
            checkPassWordTextField
        ].forEach {
            textFieldStackView.addArrangedSubview($0)
        }
        
        [
            profileImageView,
            textFieldStackView
        ].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        [
            cancelButton,
            checkButton
        ].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [
            topStackView,
            selfIntroduction,
            buttonStackView
        ].forEach {
            view.addSubview($0)
        }
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        selfIntroduction.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true

        selfIntroduction.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 32).isActive = true
        selfIntroduction.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        selfIntroduction.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        selfIntroduction.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -32).isActive = true
        
        buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
    }
    
    //MARK: next button 조건 확인 함수
    func checkNextButton() {
        guard idTextField.text != nil,
              let password = passwordTextField.text,
              let checkPassword = checkPassWordTextField.text,
              profileImageView.image != nil,
              !selfIntroduction.text.isEmpty
        else {
            checkButton.isEnabled = false
            return
        }
        
        guard password == checkPassword else {
            checkButton.isEnabled = false
            return
        }
        
        checkButton.isEnabled = true
    }
    
    //MARK: UserInformation value 확인
    private func checkAllValue() {
        idTextField.text = UserInformation.shared.id ?? nil
        passwordTextField.text = UserInformation.shared.password ?? nil
        checkPassWordTextField.text = UserInformation.shared.password ?? nil
        selfIntroduction.text = UserInformation.shared.password ?? nil
        profileImageView.image = UserInformation.shared.profile ?? nil
    }
    
    //MARK: @Objc
    @objc func popSignUpView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func pushDetailSignView() {
        UserInformation.shared.id = idTextField.text
        UserInformation.shared.password = passwordTextField.text
        UserInformation.shared.profile = profileImageView.image
        UserInformation.shared.information = selfIntroduction.text
        let viewController = SignUpDetailViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func imageViewTapped() {
        present(imagePicker, animated: true)
    }
}

//MARK: UIImagePicker
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
        }
                
        checkNextButton()
        
        self.dismiss(animated: true)
    }
}

//MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    private func textFieldDidChangeSelection(_ textView: UITextView) {
        checkNextButton()
    }
}

//MARK: UITextViewDelegate
extension SignUpViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        checkNextButton()
    }
}

//MARK: UIGestureRecognizerDelegate
extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        
        return true
    }
}
