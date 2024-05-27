//
//  ViewController.swift
//  datePicker
//
//  Created by 전성훈 on 2023/05/12.
//

import UIKit

class ViewController: UIViewController {
    var datePicker1 = UIDatePicker()
    var label = UILabel()
    var textField = UITextField()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        view.backgroundColor = .systemBackground
        
        datePicker1.datePickerMode = .dateAndTime
        datePicker1.preferredDatePickerStyle = .wheels
        
        datePicker1.addTarget(self, action: #selector(didChanged(_:)), for: .valueChanged)
        
        label.text = "Test"
        
        textField.placeholder = "Text"
        textField.borderStyle = .roundedRect
        textField.tintColor = .black
        textField.clearButtonMode = .always
        textField.keyboardType = .emailAddress
        
        
        [datePicker1, label, textField].forEach {
            view.addSubview($0)
        }
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.delegate = self
        
        view.addGestureRecognizer(tapRecognizer)
        
        
        datePicker1.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            datePicker1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: datePicker1.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewWillAppear")
    }
    
    @objc func didChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        
        let dateString: String = dateFormatter.string(from: date)
        
        
        label.text = dateString
    }
    
//    @objc func tapView() {
//        self.view.endEditing(true)
//    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
