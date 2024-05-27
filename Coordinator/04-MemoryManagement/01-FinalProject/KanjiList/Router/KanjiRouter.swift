/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class KanjiRouter: NSObject, Router {

  private var completions: [UIViewController : () -> Void]
  
  public var rootViewController: UIViewController? {
    return navigationController.viewControllers.first
  }
  
  public unowned let navigationController: UINavigationController
  
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.completions = [:]
    super.init()
    self.navigationController.delegate = self
  }
  
  public func toPresentable() -> UIViewController {
    return navigationController
  }
  
  public func present(_ module: Showable, animated: Bool) {
    
    navigationController.present(module.toShowable(), animated: animated, completion: nil)

  }
  
  public func dismissModule(animated: Bool, completion: (() -> Void)?) {
    
    navigationController.dismiss(animated: animated, completion: completion)
  
  }
  
  public func push(_ module: Showable, animated: Bool = true, completion: (() -> Void)? = nil) {
    // Avoid pushing UINavigationController onto stack
    let controller = module.toShowable()
    
    // Avoid pushing UINavigationController onto stack
    guard controller is UINavigationController == false else {
      return
    }
    
    if let completion = completion {
      completions[controller] = completion
    }
    navigationController.pushViewController(controller, animated: animated)
  }
  
  public func pop(animated: Bool = true)  {

    if let controller = navigationController.popViewController(animated: animated) {
      runCompletion(for: controller)
    }
  }

  fileprivate func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else {
      return
    }
    completion()
    completions.removeValue(forKey: controller)
  }
}


extension KanjiRouter: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
    //Make sure the view controller is popping, not pushing, and check for existence
    guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(poppedViewController) else {
      return
    }
    
    //as long as the closure is properly setup, it can now be used to clean up any resources
    runCompletion(for: poppedViewController)
  }
  
  
}
