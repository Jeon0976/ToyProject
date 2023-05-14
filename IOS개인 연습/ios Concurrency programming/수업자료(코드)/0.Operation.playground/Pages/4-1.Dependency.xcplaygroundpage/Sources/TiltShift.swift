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

// TiltShift(이미지변형)하는 동기 함수
public func tiltShift(image: UIImage?) -> UIImage? {
    guard let image = image else { return .none }
    sleep(1)
    let mask = topAndBottomGradient(size: image.size)
    return image.applyBlur(radius: 6, maskImage: mask)
}

// TiltShift(이미지변형)하는 동기 함수를 오퍼레이션큐에 직접보내 비동기함수처럼 만들고, 실행완료시 이미지로 콜백함수를 실행
func tiltShiftAsync(image: UIImage?, callback: @escaping (UIImage?) ->()) {
    OperationQueue().addOperation {
        let result = tiltShift(image: image)
        callback(result)
    }
}

// 오퍼레이션(TiltShift하는 동기 함수를 가지는)
public class TiltShiftOperation : Operation {
    public var inputImage: UIImage?
    public var outputImage: UIImage?
    
    override public func main() {
        guard let inputImage = inputImage else { return }
        outputImage = tiltShift(image: inputImage)
    }
}

