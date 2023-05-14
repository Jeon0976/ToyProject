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

class TiltShiftTableViewController: UITableViewController {
    
    // 테이블뷰 생성시 모델에서 배열가지고 오기
    let imageList = TiltShiftImage.loadDefaultData()
    
    // 취소하기위한 객체를 보관
    var imageProviders = Set<TiltShiftImageProvider>()
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    // 🎾 셀 표시 메서드 (다만, 이곳에서, 프레임을 떨어뜨리는 일을 하면 안됨)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TiltShiftCell", for: indexPath)
        
        // 셀에 필요한 "tiltShiftImage"구조체만 전달
        if let cell = cell as? ImageTableViewCell {
            cell.tiltShiftImage = imageList[indexPath.row]
        }
        
        return cell
    }
}

// 확장 - 델리게이트 메서드
extension TiltShiftTableViewController  {
    // 🎾 셀이 표시 되려고 할때(will display)
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? ImageTableViewCell else { return }
        
        // 🔸 (오퍼레이션큐를 포함하고있는) 이미지 제공 클래스
        let imageProvider = TiltShiftImageProvider(tiltShiftImage: imageList[indexPath.row]) {
            image in
            
            // 메인큐에서 실행되어야 함
            OperationQueue.main.addOperation {
                cell.updateImageViewWithImage(image)
            }
        }
        
        // "Set"에 일단 "TiltShiftImageProvider" 객체 저장하기 ===> 나중에 취소가능하게 하려면 추적해야함
        imageProviders.insert(imageProvider)
    }
    
    // 🎾 셀 표시가 끝났을 때(did end displaying)
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? ImageTableViewCell else { return }
        
        // 이미지제공 객체 찾아서 취소하기
        for provider in imageProviders.filter({ $0.tiltShiftImage == cell.tiltShiftImage }) {
            provider.cancel()
            
            // "Set"에서 객체도 지우기
            imageProviders.remove(provider)
        }
    }
    
}
