//
//  ViewController.swift
//  textfieldtest
//
//  Created by 전성훈 on 5/12/24.
//

import UIKit

class ViewController: UIViewController {

    private let test: TestField = {
        let field = TestField()
        
        field.addTarget(self, action: #selector(testEE(_:)), for: .editingDidBegin)
        field.addTarget(self, action: #selector(testEE(_:)), for: .editingChanged)
        field.textFieldShouldSearch = {
            print(field.text)
        }
        
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        test.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(test)
        test.delegate = self
        
        NSLayoutConstraint.activate([
            test.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            test.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            test.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        ])
    }

    @objc func testEE(_ sender: TestField) {
        if sender.text != "" {
            sender.rightButtonHidden = false
            sender.isEditingField = true
        } else {
            sender.rightButtonHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        test.endEditing(true)
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.view.endEditing(true)
        
        print(textField.text)
        return true
    }
}

final class TestField: UITextField {
    private let inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16 + 24 + 2)
    private let buttonSize: CGFloat = 24
    
    private let rightButton = UIButton()
    
    override func endEditing(_ force: Bool) -> Bool {
        
        self.rightButtonHidden = !force
        self.isEditingField = !force
        
        return force
    }
    
    var _isEditingField: Bool = false
    var isEditingField: Bool {
        get { return _isEditingField }
        set {
            if !(newValue == _isEditingField) {
                
                let image = newValue ? UIImage(systemName: "x.circle") : UIImage(systemName: "magnifyingglass")
                rightButton.setImage(image, for: .normal)
                
                _isEditingField = newValue
            }
        }
    }
    
    var rightButtonHidden = false {
        didSet {
            rightView?.isHidden = rightButtonHidden
        }
    }
    
    var textFieldShouldSearch: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeRightButton()
        self.layer.cornerRadius = 15
        self.textColor = .black
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.returnKeyType = .search
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
    
    private func makeRightButton() {
        let image2 = UIImage(systemName: "magnifyingglass")
                 
        rightButton.setImage(image2, for: .normal)
        rightButton.frame = .init(x: 0, y: 0, width: buttonSize, height: buttonSize)
        rightButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24 + 16, height: 24))
        
        paddingView.addSubview(rightButton)
        
        rightView = paddingView
        rightViewMode = .always
    }
    
    @objc private func rightButtonTapped(_ sender: UIButton) {
        
        if isEditingField {
            self.rightButtonHidden = true

            self.text = ""
        } else {
            if self.text == "" {
                self.becomeFirstResponder()
            } else {
                self.textFieldShouldSearch?()
            }
        }
    }
}
