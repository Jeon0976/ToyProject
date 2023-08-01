//
//  ViewController.swift
//  test
//
//  Created by 전성훈 on 2023/02/08.
//

import UIKit

class FrameAnctor: UIViewController {
    var button3 = test()
    var button2 = test()
    var button4 = test()
    
    var testView = UIView()
    var test2View = UIView()
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(view.frame)
    
        view.backgroundColor = .white
        
        testView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testView)
        
        NSLayoutConstraint.activate([
            testView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            testView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        test2View.translatesAutoresizingMaskIntoConstraints = false
        testView.addSubview(test2View)
        
        NSLayoutConstraint.activate([
            test2View.leadingAnchor.constraint(equalTo: testView.leadingAnchor, constant: 16),
            test2View.trailingAnchor.constraint(equalTo: testView.trailingAnchor, constant: -16),
            test2View.topAnchor.constraint(equalTo: testView.topAnchor, constant: 16),
            test2View.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -16)
        ])
        test2View.backgroundColor = .systemBlue
        testView.backgroundColor = .systemGray
        print("test inner:", testView.frame)
        print("inner: ",test2View.frame)
        
        
        [
            button4,
            button2,
            button3
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            button4.widthAnchor.constraint(equalToConstant: (view.frame.width - 84) / 3),
            button2.widthAnchor.constraint(equalToConstant: (view.frame.width - 84) / 3),
            button3.widthAnchor.constraint(equalToConstant: (view.frame.width - 84) / 3)
        ])
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        [
            stackView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        print("stackView" ,stackView.frame)
        
        button4.setTitle("모든 메뉴가\n비건", for: .normal)
        button4.setTitleColor(.red, for: .normal)
        button4.setImage(UIImage(named: "bxs-cube.svg")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button4.titleLabel?.numberOfLines = 2
        button4.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button4.tintColor = .systemGray4
        
        button4.backgroundColor = .systemGray6
        button4.layer.cornerRadius = 10
        button4.verticalTitleToImage(spacing: 32)
        
        button2.setTitle("모든 메뉴가\n비건", for: .normal)
        button2.setTitleColor(.red, for: .normal)
        button2.setImage(UIImage(named: "bxs-cube.svg")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button2.titleLabel?.numberOfLines = 2
        button2.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button2.tintColor = .systemGray4
        
        button2.backgroundColor = .systemGray6
        button2.layer.cornerRadius = 10
        button2.verticalTitleToImage(spacing: 32)
        
        button3.setTitle("모든 메뉴가\n비건", for: .normal)
        button3.setTitleColor(.red, for: .normal)
        button3.setImage(UIImage(named: "bxs-cube.svg")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        button3.titleLabel?.numberOfLines = 2
        button3.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button3.tintColor = .systemGray4
        
        button3.backgroundColor = .systemGray6
        button3.layer.cornerRadius = 10
        button3.verticalTitleToImage(spacing: 32)
        print("button frame:", button2.frame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        print("test outter:", testView.frame)
        print("outter: ", test2View.frame)
        print("stackView: " ,stackView.frame)

    }
}


final class test: UIButton {
    
    func verticalTitleToImage(spacing: CGFloat) {
        let imageSize: CGSize = self.imageView?.bounds.size ?? .zero
        let titleSize: CGSize = self.titleLabel?.bounds.size ?? .zero

        let totalHeight: CGFloat = imageSize.height + titleSize.height + spacing

        // 이미지가 버튼의 아래에 오도록 설정
        imageEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: -(totalHeight - imageSize.height),
            right: -titleSize.width + (-titleSize.width / 2) - 12
        )

        // 텍스트가 버튼의 위에 오도록 설정
        titleEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - titleSize.height),
            left: -imageSize.width,
            bottom: 0.0,
            right: -0.0
        )

        contentEdgeInsets = UIEdgeInsets(
            top: (totalHeight - bounds.size.height) / 2 + 12,
            left: -bounds.size.width/2 + titleSize.width/2 + 12 ,
            bottom: (totalHeight - bounds.size.height) / 2 + 12,
            right: -bounds.size.width/2 + titleSize.width/2 + 12
        )
    }
}
