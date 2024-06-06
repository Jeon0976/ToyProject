//
//  ViewModel.swift
//  SwiftUIMVVM
//
//  Created by 전성훈 on 6/5/24.
//

import Combine

final class HomeViewModel: ObservableObject {
    enum ViewState {
        case START
        case LOADING
        case SUCCESS(users: [User])
        case FAILURE(error: String)
    }
    
    @Published var currentState: ViewState = .START
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        self.currentState = .LOADING
        
        APIService.shared.getUsers()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finished")
                case.failure(let error):
                    self.currentState = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { users in
                self.currentState = .SUCCESS(users: users)
            }.store(in: &cancelables)
    }
}
