//
//  SelectViewModel.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/25.
//

import Foundation
import Combine

class SelectRegionViewModel: ObservableObject {
    @Published var centers = [Center.Sido: [Center]]()
    private var cancellable = Set<AnyCancellable>()
    
    init(CenterNetwork: CenterNetwork = CenterNetwork()) {
        CenterNetwork.getCenterList()
            .receive(on: DispatchQueue.main)
        //subscribe
            .sink(
                receiveCompletion: {[weak self] in
                    guard case .failure(let error) = $0 else {return}
                    print(error.localizedDescription)
                    self?.centers = [Center.Sido: [Center]]()
                },
                receiveValue: {[weak self] centers in
                    self?.centers = Dictionary(grouping: centers) {$0.sido}
                }
            )
            .store(in: &cancellable)
    }
}
