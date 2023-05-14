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

protocol ImageFilterDataProvider {
    var image: UIImage? { get }
}

// "이미지 필터 오퍼레이션" 추상 클래스 (인풋 - 아웃풋)
class ImageFilterOperation: Operation {
    
    var filterOutput: UIImage?
    fileprivate let _filterInput: UIImage?
    
    // 생성시 "_filterInput"(옵셔널) ===> (1.이미지로 생성 또는 2.의존성(오퍼레이션)에 의거 이미지 뽑아내기) "filterInput"
    init(image: UIImage?) {
        _filterInput = image
        super.init()
    }
    
    var filterInput: UIImage? { 
        var image: UIImage?
        
        // (1) "_filterInput"에 이미지 있으면 "image"에 대입 ===> "filterInput"
        if let inputImage = _filterInput {
            image = inputImage
            
        // (2) 의존성에 의거 "ImageFilterDataProvider"에서 이미지 데이터 ===> "filterInput"
        } else if let dataProvider = dependencies
            .filter({ $0 is ImageFilterDataProvider })
            .first as? ImageFilterDataProvider {
            image = dataProvider.image
        }
        return image
    }
}

// 프로토콜 채택
extension ImageFilterOperation: ImageFilterDataProvider {
    var image: UIImage? {
        return filterOutput
    }
}
