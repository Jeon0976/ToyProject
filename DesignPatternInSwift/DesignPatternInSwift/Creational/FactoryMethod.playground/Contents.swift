import Foundation

protocol AppleFactory {
    func createElectronics() -> Product
}

class IPhoneFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPhone()
    }
}

class IPadFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPad()
    }
}


protocol Product {
    func produceProduct()
}

class IPhone: Product {
    func produceProduct() {
        print("IPhone was made")
    }
}

class IPad: Product {
    func produceProduct() {
        print("IPad was made")
    }
}

class Client {
    func order(factory: AppleFactory) {
        let electronicsProduct = factory.createElectronics()
        electronicsProduct.produceProduct()
    }
}

var client = Client()
client.order(factory: IPadFactory())


protocol Shape {
    func draw()
}

class Rectangle: Shape {
    func draw() {
        print("Rectangle")
    }
}

class Circle: Shape {
    func draw() {
        print("Circle")
    }
}

class ShapeFactory {
    func createShape(type: String) -> Shape? {
        switch type {
        case "rectangle":
            return Rectangle()
        case "circle":
            return Circle()
        default:
            return nil
        }
    }
}

let factory = ShapeFactory()

if let shape1 = factory.createShape(type: "rectangle") {
    shape1.draw()
}

if let shape2 = factory.createShape(type: "circle") {
    shape2.draw()
}
