//
//  Bundle.swift
//  SwiftUIExample
//
//  Created by 전성훈 on 5/27/24.
//

import Foundation

extension Bundle {
    func jsonDecode<T: Decodable> (filename: String, as type: T.Type) -> T {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            fatalError("번들에 \(filename)이 없습니다.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("\(url)로부터 데이터를 불러올 수 없습니다.")
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("복호화 실패")
        }
        
        return decodedData
    }
}
