/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // TiltShiftImage 구조체를 담는 변수
    var tiltShiftImage: TiltShiftImage? {
        didSet {
            if let tiltShiftImage = tiltShiftImage {
                titleLabel.text = tiltShiftImage.title
                updateImageViewWithImage(nil)
            }
        }
    }
    
    // 이미지 및 액티비티 인디케이터 업데이트 메서드
    func updateImageViewWithImage(_ image: UIImage?) {
        // 이미지가 있을때 ===> 이미지 표시
        if let image = image {
            tsImageView.image = image
            tsImageView.alpha = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.tsImageView.alpha = 1.0
                self.activityIndicator.alpha = 0
            }, completion: {
                _ in
                self.activityIndicator.stopAnimating()
            })
            
        // 이미지 없을때
        } else {
            tsImageView.image = nil
            tsImageView.alpha = 0
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        }
    }
}




