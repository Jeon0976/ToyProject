import UIKit

// 추상화된 Factory
protocol UIFactoryable {
    func createButton() -> Buttonable
    func createLabel() -> Labelable
}

// 연관된 제품군을 실제로 생성하는 구체 Factory
final class IPadUIFactory: UIFactoryable {
    func createButton() -> Buttonable {
        return IPadButton()
    }
    
    func createLabel() -> Labelable {
        return IPadLabel()
    }
}

final class IPhoneUIFactory: UIFactoryable {
    func createButton() -> Buttonable {
        return IPhoneButton()
    }
    
    func createLabel() -> Labelable {
        return IPhoneLabel()
    }
}


// 추상화된 Product
protocol Buttonable {
    func touchUp()
}

protocol Labelable {
    var title: String { get }
}
// 실제로 생성될 구체 Product, 객체가 가질 기능과 상태를 구현
final class IPhoneButton: Buttonable {
    func touchUp() {
        print("IPhone Button")
    }
}

final class IPadButton: Buttonable {
    func touchUp() {
        print("IPad Button")
    }
}

final class IPhoneLabel: Labelable {
    var title: String = "iPhoneLabel"
}

final class IPadLabel: Labelable {
    var title: String = "iPadLabel"
}



class ViewController1: UIViewController {

        //UI를 가지고 있는 인스턴스 기기별로 설정
    var iPadUIContent = UIContent(uiFactory: IPadUIFactory())
    var iPhoneUIContent = UIContent()

    override func viewDidLoad() {
        super.viewDidLoad()
        touchUpButton()
        printLabelTitle()
    }

    func touchUpButton() {
        iPadUIContent.button?.touchUp()
        iPhoneUIContent.button?.touchUp()
    }

    func printLabelTitle() {
        print(iPadUIContent.label?.title ?? "")
        print(iPhoneUIContent.label?.title ?? "")
    }
}

// Factory를 통해 UI를 만들고 가지고 있는 Class
class UIContent {
    var uiFactory: UIFactoryable
    var label: Labelable?
    var button: Buttonable?
    
    
    init(uiFactory: UIFactoryable = IPhoneUIFactory()) {
        self.uiFactory = uiFactory
        setUpUI()
    }
    
    func setUpUI() {
        label = uiFactory.createLabel()
        button = uiFactory.createButton()
    }
}

// 추상 팩토리
protocol ThemeFactory {
    func createBackgroundColor() -> UIColor
    func createTextColor() -> UIColor
}

// 라이트 테마 팩토리
class LightThemeFactory: ThemeFactory {
    func createBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    func createTextColor() -> UIColor {
        return UIColor.black
    }
}

// 다크 테마 팩토리
class DarkThemeFactory: ThemeFactory {
    func createBackgroundColor() -> UIColor {
        return UIColor.black
    }
    
    func createTextColor() -> UIColor {
        return UIColor.white
    }
}

// ViewController
class ViewController2: UIViewController {
    private var themeFactory: ThemeFactory!
    
    // viewController 초기화 시 테마 팩토리 전달
    init(themeFactory: ThemeFactory) {
        super.init(nibName: nil, bundle: nil)
        self.themeFactory = themeFactory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.view.backgroundColor = themeFactory.createBackgroundColor()
         
         let label = UILabel()
         label.textColor = themeFactory.createTextColor()
         self.view.addSubview(label)
     }
}
