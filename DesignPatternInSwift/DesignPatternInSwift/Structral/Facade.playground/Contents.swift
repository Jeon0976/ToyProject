import UIKit

protocol Facade {
    func work()
}

struct CPU {
    func work(with menory: Memory) { }
}

struct Memory {
    func input(from devices: [Device]) { }
    func output(to devices: [Device]) { }
}

class Device { }
class InputDevice: Device { }
class OutputDevice: Device { }
class Keyboard: InputDevice { }
class Monitor: OutputDevice { }
class TouchBar: Device { }

struct Computer: Facade {
    private let cpu = CPU()
    private let memory = Memory()
    private let keyboard = Keyboard()
    private let monitor = Monitor()
    private let touchBar = TouchBar()
    
    func work() {
        memory.input(from: [keyboard, touchBar])
        cpu.work(with: memory)
        memory.output(to: [monitor])
    }
}


let computer = Computer()
computer.work()

// Subsystem
class NetworkManager {
    func requestData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        // Network request logic
    }
}

// Facade
class ImageLoader {
    private let networkManager = NetworkManager()

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        networkManager.requestData(from: url) { data, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}

// Client
let url = URL(string: "https://example.com/image.png")!
let imageLoader = ImageLoader()
imageLoader.loadImage(from: url) { image in
    // Use the image
}

