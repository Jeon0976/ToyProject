import UIKit

// flyweight
protocol Flyweight {
    var sharedState: String { get }
}

// concrete flyweight
class ConcreteFlyweight: Flyweight {
    var sharedState: String
    
    init(sharedState: String) {
        self.sharedState = sharedState
    }
}

// flyweight factory
class FlyweightFactory {
    private var flyweights: [String: Flyweight] = [:]
    
    init(states: [String]) {
        states.forEach { state in
            flyweights[state] = ConcreteFlyweight(sharedState: state)
        }
    }
    
    func getFlyweight(for state: String) -> Flyweight {
        if let flyweight = flyweights[state] {
            return flyweight
        } else {
            let flyweight = ConcreteFlyweight(sharedState: state)
            flyweights[state] = flyweight
            return flyweight
        }
    }
}

let factory = FlyweightFactory(states: ["1","2","3"])
let flyweight = factory.getFlyweight(for: "2")

// MARK: Image cache 처리
class ImageCache {
    private var imageCache = NSCache<NSString, UIImage>()
    
    func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            DispatchQueue.global().async {
                if let url = URL(string: url),
                   let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }
}

let imageCache = ImageCache()

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let imageUrl = "https://example.com/image.jpg" // 실제 이미지 URL로 교체해야 합니다.
    imageCache.getImage(url: imageUrl) { image in
        cell.imageView?.image = image
    }
    return cell
}
