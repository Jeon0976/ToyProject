//
//  ViewController.swift
//  ImagePicker
//
//  Created by 전성훈 on 2023/05/11.
//

import UIKit

class ViewController: UIViewController {

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    }()
    
    var stackView = UIStackView()
    
    var imageView = UIImageView()
    var button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    func attribute() {
        view.backgroundColor = .systemBackground
        
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
//        button.contentEdgeInsets = .init(
//            top: 10,
//            left: 20,
//            bottom: 10,
//            right: 20
//        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    
    func layout() {
        
        [imageView,button].forEach {
            stackView.addArrangedSubview($0)
        }
        [imageView, button].forEach {
            view.addSubview($0)
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
    }
    
    @objc func buttonTapped() {
        button.backgroundColor = .systemGray
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.button.backgroundColor = .systemBlue
            self?.present(self!.imagePicker, animated: true)
        }

    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true)
    }
    
}
