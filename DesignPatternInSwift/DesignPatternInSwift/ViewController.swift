//
//  ViewController.swift
//  DesignPatternInSwift
//
//  Created by 전성훈 on 2023/06/15.
//

import UIKit

class ViewController: UIViewController {
    var animation: Animation = ScaleAnimation(implementation: SpringAnimation())
    
    var testView = UIView()
    var segementedControl = UISegmentedControl(items: ["Spring", "Keyframe", "Fade", "Rotation"])
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeLayout()
        makeAttribute()

    }

    func makeLayout() {
        view.backgroundColor = .white
        [
            segementedControl,
            testView,
            button
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            segementedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            segementedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segementedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            testView.topAnchor.constraint(equalTo: segementedControl.bottomAnchor, constant: 80),
            testView.widthAnchor.constraint(equalToConstant: 200),
            testView.heightAnchor.constraint(equalToConstant: 250),
            testView.centerXAnchor.constraint(equalTo: segementedControl.centerXAnchor),
            
            button.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            button.topAnchor.constraint(equalTo: testView.bottomAnchor, constant: 30)
        ])
    }
    
    func makeAttribute() {
        testView.backgroundColor = .darkGray
        testView.layer.borderColor = UIColor.red.cgColor
        testView.layer.borderWidth = 1
        testView.layer.cornerRadius = 16
        
        button.setTitle("발동!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapAnimateButton), for: .touchUpInside)
        
        segementedControl.selectedSegmentIndex = 0
        segementedControl.addTarget(self, action: #selector(didChangeAnimationType(_:)), for: .valueChanged)
    }
    
    @objc func didTapAnimateButton() {
        animation.perfomAnimation(view: testView)
    }
    
    @objc func didChangeAnimationType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            animation = ScaleAnimation(implementation: SpringAnimation())
        case 1:
            animation = ScaleAnimation(implementation: KeyframeAnimation())
        case 2:
            animation = FadeAnimation(implementation: FadeAnimationImplementation())
        case 3:
            animation = RotationAnimation(implementation: RotationAnimationImplementation())
        default:
            break
        }
    }
}


// 추상화
protocol Animation {
    var implementation: AnimationImplementation { get }
    func perfomAnimation(view: UIView)
}

class ScaleAnimation: Animation {
    let implementation: AnimationImplementation
    
    init(implementation: AnimationImplementation) {
        self.implementation = implementation
    }
    
    func perfomAnimation(view: UIView) {
        implementation.animate(view: view)
    }
}

class FadeAnimation: Animation {
    let implementation: AnimationImplementation
    
    init(implementation: AnimationImplementation) {
        self.implementation = implementation
    }
    
    func perfomAnimation(view: UIView) {
        implementation.animate(view: view)
    }
}

class RotationAnimation: Animation {
    let implementation: AnimationImplementation
    
    init(implementation: AnimationImplementation) {
        self.implementation = implementation
    }
    
    func perfomAnimation(view: UIView) {
        implementation.animate(view: view)
    }
}

// 구현
protocol AnimationImplementation {
    func animate(view: UIView)
}

// 구체적인 구현
class SpringAnimation: AnimationImplementation {
    func animate(view: UIView) {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut
        ) {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
}

class KeyframeAnimation: AnimationImplementation {
    func animate(view: UIView) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                view.transform = CGAffineTransform.identity
            }
        } completion: { _ in
            return
        }
    }
}

class FadeAnimationImplementation: AnimationImplementation {
    func animate(view: UIView) {
        UIView.animate(withDuration: 0.5) {
            view.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                view.alpha = 1
            }
        }
    }
}

class RotationAnimationImplementation: AnimationImplementation {
    func animate(view: UIView) {
        UIView.animate(withDuration: 0.5) {
            view.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                view.transform = CGAffineTransform.identity
            }
        }
    }
}
