//
//  CustomImageView.swift
//  Concurrency
//
//  Created by Allen on 2020/02/04.
//  Copyright © 2020 allen. All rights reserved.
//

import UIKit

//이미지 캐시처리
var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    // 액티비티인디케이터 설정
    var isLoading: Bool {
      get { return activityIndicator.isAnimating }
      set {
        if newValue {
          activityIndicator.startAnimating()
        } else {
          activityIndicator.stopAnimating()
        }
      }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        self.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        return indicator
    }()
    
    // 경로 확인
    var lastImgUrlUsedToLoadImage: String?
    
    func loadImage(with urlString: String) {
        
        self.image = nil
        
        // 마지막으로 이미지를 다운로드한 String경로
        lastImgUrlUsedToLoadImage = urlString
        
        // 이미지가 캐시에 먼저 확인하기
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            self.isLoading = false
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        // URL세션
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Failed to load image with error", error.localizedDescription)
            }
            
            if self.lastImgUrlUsedToLoadImage != url.absoluteString {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            // 이미지 캐시 저장
            imageCache[url.absoluteString] = photoImage
            
            // 🎾 이미지 셋팅 (메인큐에서) 🎾
            DispatchQueue.main.async {
                self.image = photoImage
                self.isLoading = false
            }
        }.resume()
    }
    
}
