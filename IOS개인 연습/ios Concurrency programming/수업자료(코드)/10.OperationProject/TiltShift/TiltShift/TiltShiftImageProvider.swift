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

// 이미지를 제공하는 클래스
class TiltShiftImageProvider {
    
    // 🎾 오퍼레이션 객체 생성
    fileprivate let operationQueue = OperationQueue()
    
    let tiltShiftImage: TiltShiftImage
    
    // 이니셜라이저에 <컴플리션 핸들러 더하기(셀에 이미지 전달)>
    init(tiltShiftImage: TiltShiftImage, completion: @escaping (UIImage?) -> ()) {
        
        self.tiltShiftImage = tiltShiftImage
        
        // 🔸url
        let url = Bundle.main.url(forResource: tiltShiftImage.imageName, withExtension: "compressed")!
        
        // 🔸오퍼레이션 생성하기
        let dataLoad = DataLoadOperation(url: url)
        let imageDecompress = ImageDecompressionOperation(data: nil)
        let tiltShift = TiltShiftOperation(image: nil)
        let filterOutput = ImageFilterOutputOperation(completion: completion)
        
        // 🔸오퍼레이션 배열
        let operations = [dataLoad, imageDecompress, tiltShift, filterOutput]
        
        // 🔸디펜던시 더하기
        imageDecompress.addDependency(dataLoad)
        tiltShift.addDependency(imageDecompress)
        filterOutput.addDependency(tiltShift)
        
        // 🔸오퍼레이션큐에 오퍼레이션 넣기 (앱이기 때문에 기다리지 않기)
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
    }
    
    // 취소메서드
    func cancel() {
        operationQueue.cancelAllOperations()
    }
    
}

extension TiltShiftImageProvider: Hashable {
    var hashValue: Int {
        return (tiltShiftImage.title + tiltShiftImage.imageName).hashValue
    }
}

func ==(lhs: TiltShiftImageProvider, rhs: TiltShiftImageProvider) -> Bool {
    return lhs.tiltShiftImage == rhs.tiltShiftImage
}

