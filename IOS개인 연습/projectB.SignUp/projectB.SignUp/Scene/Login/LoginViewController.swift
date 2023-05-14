//
//  LoginViewController.swift
//  projectB.SignUp
//
//  Created by 전성훈 on 2023/05/12.
//
// MARK: 질문
// MVP 패턴으로 전환, 조금더 가독성이 좋은 layout 코드 작성에는 어떤 방법이 있을지 궁금합니다.


import UIKit

final class LoginViewController: UIViewController {
    //MARK: Property
    var siteImageView = UIImageView()
    var idTextField = UITextField()
    var passwordTextField = UITextField()
    var signInButton = UIButton()
    var signUpButton = UIButton()
    
    var inputStackView = UIStackView()
    var buttonStackView = UIStackView()
    
    var tapRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttribute()
        setUpLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        idTextField.text = UserInformation.shared.id ?? nil
    }
    //MARK: SetUp Attribute
    func setUpAttribute() {
        view.backgroundColor = .systemBackground
        
        // 무료 image site 활용
        guard let url = URL(string: "https://img.freepik.com/free-photo/creative-reels-composition_23-2149711507.jpg?w=996&t=st=1683887131~exp=1683887731~hmac=1ba8d046f8dccecdf2c4998eab318cc583682d6bfe1a99ca7be9bd941a6a45b3"
        ) else {
            print("image error")
            return
        }
        
        // Image 불러오기
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.siteImageView.image = image
                }
            }
        }.resume()
        
        siteImageView.layer.cornerRadius = 16
        siteImageView.clipsToBounds = true
        
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        idTextField.clearButtonMode = .always
        idTextField.backgroundColor = .secondarySystemBackground
        
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.clearButtonMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .secondarySystemBackground
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.systemBlue, for: .normal)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemRed, for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        inputStackView.axis = .vertical
        inputStackView.spacing = 6
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 12
        buttonStackView.distribution = .fillEqually
        
    }
    
    //MARK: SetUp Layout
    func setUpLayout() {
        [
            idTextField,
            passwordTextField
        ].forEach {
            inputStackView.addArrangedSubview($0)
        }
        
        [
            signInButton,
            signUpButton
        ].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        [
            siteImageView,
            inputStackView,
            buttonStackView
        ].forEach {
            view.addSubview($0)
        }
        
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        
        siteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        siteImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        siteImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        siteImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        siteImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        inputStackView.centerXAnchor.constraint(equalTo: siteImageView.centerXAnchor).isActive = true
        inputStackView.topAnchor.constraint(equalTo: siteImageView.bottomAnchor, constant: 32).isActive = true
        inputStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 16).isActive = true
        buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        buttonStackView.centerXAnchor.constraint(equalTo: inputStackView.centerXAnchor).isActive = true
    }
}
//MARK: @Objc
extension LoginViewController {
    @objc func signUpTapped() {
        let signUpView = SignUpViewController()
                
        navigationController?.pushViewController(signUpView, animated: true)
    }
}


//MARK: UIGestureRecognizerDelegate
extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
