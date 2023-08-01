//
//  ViewController.swift
//  test
//
//  Created by 전성훈 on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    var test = testField()
    var testButton = MenuPlusButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(test)
        
        testButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testButton)
        
        NSLayoutConstraint.activate([
            test.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            test.widthAnchor.constraint(equalToConstant: 200),
            test.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            testButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            testButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        test.addRightButton()
        test.placeholder = "Test"
        test.keyboardType = .numberPad
        test.delegate = self
        
        testButton.setButton("메뉴 정보 추가하기")
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == test {
            if textField.text == "변동" {
                textField.endEditing(true)
                return false
            } else if let result = textField.text, let textRange = Range(range, in: result) {
                let updateText = result.replacingCharacters(in: textRange, with: string)
                textField.text = updateText.formatNumber()
                return false
            }
        }
        return true
    }
}


class testField: UITextField {
    private var horizontalPadding: CGFloat = 16
    private var verticalPadding: CGFloat = 12
    private var buttonPadding: CGFloat = 7
    private var buttonSize: CGFloat = 24
    
    private var isAddRightButton = false
    
    private var variablePrice: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset = setTextInset()
        
        return bounds.inset(by: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = setTextInset()
        
        return bounds.inset(by: inset)
    }
    
    private func configuration() {
        textColor = .black
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
    }
    
    private func setTextInset() -> UIEdgeInsets {
        var inset = UIEdgeInsets(
            top: verticalPadding,
            left: horizontalPadding,
            bottom: verticalPadding,
            right: horizontalPadding
        )
        
        if isAddRightButton {
            let rightInest = horizontalPadding + buttonSize + buttonPadding
            
            inset.right = rightInest
            
            return inset
        }
        
        return inset
    }
    
    func addRightButton() {
        isAddRightButton = !isAddRightButton
        
        let image = UIImage(named: "test")?.withRenderingMode(.alwaysTemplate)
        
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        button.tintColor = .blue

        button.frame = .init(x: horizontalPadding, y: 0, width: buttonSize, height: buttonSize)
        
        let paddingWidth = horizontalPadding + buttonSize + buttonPadding
        
        let paddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: paddingWidth,
            height: buttonSize)
        )
        
        paddingView.addSubview(button)
        
        rightView = paddingView
        rightViewMode = .always
    }
    
    @objc func test() {
        if variablePrice == nil {

            variablePrice = UIButton(frame: CGRect(x: self.rightView!.frame.origin.x,
                                                   y: self.rightView!.frame.origin.y + 10,
                                                   width: 56, height: 47))
            variablePrice?.setTitle("변동", for: .normal)
            variablePrice?.backgroundColor = .white
            variablePrice?.layer.cornerRadius = 10
            variablePrice?.layer.borderWidth = 1
            variablePrice?.layer.borderColor = UIColor.lightGray.cgColor
            variablePrice?.setTitleColor(.lightGray, for: .normal)
            
            variablePrice?.addTarget(self, action: #selector(changeTextField), for: .touchUpInside)
            self.addSubview(variablePrice!)
        } else {
            variablePrice?.isHidden = false
        }
    }
    
    @objc func changeTextField() {
        variablePrice?.isHidden = true

        if self.text == "변동" {
            self.text = ""
            variablePrice?.setTitle("변동", for: .normal)
            variablePrice?.frame.size.width = 56
            variablePrice?.frame.origin.x += 15
        } else {
            self.text = "변동"
            variablePrice?.setTitle("변동취소", for: .normal)
            variablePrice?.frame.size.width = 90
            variablePrice?.frame.origin.x -= 15
        }
        self.layoutIfNeeded()
    }
}


extension String {
    func formatNumber() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        print(self)
        
        let noCommaString = self.replacingOccurrences(of: ",", with: "")
        
        if let number = Int(noCommaString) {
            return numberFormatter.string(from: NSNumber(value: number))
        }
        return self
    }
}

final class MenuPlusButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func setupButton() {
        layer.cornerRadius = 27
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    func setButton(_ title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor.black
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        setAttributedTitle(attributedTitle, for: .normal)
        
        setImage(UIImage(named: "Search"), for: .normal)
        
        imageView?.contentMode = .scaleAspectFit
        semanticContentAttribute = .forceLeftToRight
        
        imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        titleEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        
        contentEdgeInsets = .init(top: 14.5, left: 32, bottom: 14.5, right: 32)
    }
}

final class CategoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(_ title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor.black
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        setAttributedTitle(attributedTitle, for: .normal)
        
        setImage(UIImage(named: "Search"), for: .normal)
        setImage(UIImage(named: "Search"), for: .selected)
        
        self.imageView?.contentMode = .scaleAspectFit
        self.semanticContentAttribute = .forceLeftToRight
        self.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 7)
        self.titleEdgeInsets = .init(top: 0, left: 7, bottom: 0, right: 0)
    }
}
