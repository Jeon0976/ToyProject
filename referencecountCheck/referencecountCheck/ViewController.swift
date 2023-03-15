//
//  ViewController.swift
//  referencecountCheck
//
//  Created by 전성훈 on 2023/01/30.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        button.configuration = .filled()
        button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        print("main before super.viewDidLoad \(CFGetRetainCount(self))")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("main after super.viewDidLoad \(CFGetRetainCount(self))")
        view.backgroundColor = .systemGray
        setup()
    }
    
    @objc func pushButton() {
        let timerView = TimerViewController()
        navigationController?.pushViewController(timerView, animated: true)
    }
    
    func setup() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    deinit {
        print("Main Deinit")
    }
}

class TimerViewController: UIViewController {
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    private var timer: Timer = Timer()
    private var repeatCount: Int = 0
    
    override func viewDidLoad() {
        print("timer before super.viewDidLoad \(CFGetRetainCount(self))")

        super.viewDidLoad()
        print("안녕")
        view.backgroundColor = .gray
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: {[weak self] timer in
            self?.repeatCount += 1
            print("Repeat Count: \(self?.repeatCount)")
            self?.timerLabel.text = "\(self?.repeatCount)"
            print("timer inside scheduled \(CFGetRetainCount(self))")
        })
    }
    
    deinit {
        print("Timer Deinit")
        self.timer.invalidate()
    }
    
}
