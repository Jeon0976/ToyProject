
import UIKit

class ViewController: UIViewController {
    
    private lazy var toggleTest: CustomToggleButton = {
        let btn = CustomToggleButton()
        
        btn.layer.cornerRadius = 17
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [
            toggleTest
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            toggleTest.widthAnchor.constraint(equalToConstant: 105),
            toggleTest.heightAnchor.constraint(equalToConstant: 33),
            toggleTest.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toggleTest.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
