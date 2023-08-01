import UIKit

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
