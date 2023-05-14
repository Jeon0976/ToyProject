//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # UI업데이트
//: ### 유저인터페이스(즉, 화면)와 관련된 작업은 메인쓰레드에서 진행해야 함

//: ## 프로젝트에서 UI-update사용하는 예제
// 이미지캐시 처리하는 예제
var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastImgUrlUsedToLoadImage: String?
    
    func loadImage(with urlString: String) {
        
        self.image = nil
        
        // 마지막으로 이미지를 다운로드한 String경로
        lastImgUrlUsedToLoadImage = urlString
        
        // 이미지가 캐시에 들어 있는지 확인하기
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        // url
        guard let url = URL(string: urlString) else { return }
        
        // 🎾 URL세션은 내부적으로 비동기로 처리된 함수임.
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("Failed to load image with error", error.localizedDescription)
            }
            
            if self.lastImgUrlUsedToLoadImage != url.absoluteString {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            // 🎾 이미지 표시는 DispatchQueue.main에서 🎾
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
        }.resume()
    }
}




PlaygroundPage.current.finishExecution()

//: [Next](@next)
