//
//  CenterNetwork.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/24.
//

import Foundation
import Combine

class CenterNetwork {
    // URLSession vs URLSessionTask??
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // AnyPublisher -> Observable 기본적으로 data뿐만 아니라 Error도 같이 선언
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Infuser BG7O2mHxa+FDMMOBPnj/9hravNmNGAIhP2GpR5W5sxaCcwppFnFrB6ezjWfDrMu9wM++IF8375cVfi5gShMbAA==", forHTTPHeaderField: "Authorization")
        
        
        // What is dataTaskPublisher??
        return session.dataTaskPublisher(for: request)
        // Combine operator
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                
                switch httpResponse.statusCode {
                case 200..<300:
                    return data
                case 400..<500:
                    throw URLError(.clientCertificateRejected)
                case 500..<600:
                    throw URLError(.badServerResponse)
                default:
                    throw URLError(.unknown)
                }
            }
        // JSON Decoder를 만든 것과 동일
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder())
        // data만 뽑아라
            .map { $0.data }
            .mapError{ $0 as! URLError }
            .eraseToAnyPublisher()
    }
}
