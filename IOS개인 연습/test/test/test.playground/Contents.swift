protocol DIProtocol {
    func register<Service>(type: Service.Type, service: Any)
    func resolve<Service>(type: Service.Type) -> Service?
}

final class AppDIContainer: DIProtocol {
    static let shared = AppDIContainer()
    
    private init() { }
    
    var services: [String: Any] = [:]
    
    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"] as? Service
    }
}

protocol UserServiceProtocol {
    func fetchUsers()
}

protocol RewardServiceProtocol {
    func fetchRewards()
}

final class UserService: UserServiceProtocol {
    func fetchUsers() {
        print("User fetching")
    }
}

final class RewardService: RewardServiceProtocol {
    func fetchRewards() {
        print("Reward fetching")
    }
}


final class ViewModel {
    private let userService: UserServiceProtocol
    private let rewardService: RewardServiceProtocol
    
    init(
        userService: UserServiceProtocol = AppDIContainer.shared.resolve(type: UserServiceProtocol.self)!,
        rewardService: RewardServiceProtocol = AppDIContainer.shared.resolve(type: RewardServiceProtocol.self)!
    ) {
        self.userService = userService
        self.rewardService = rewardService
    }
    
    func fetchUsers() {
        userService.fetchUsers()
    }
    
    func fetchRewards() {
        rewardService.fetchRewards()
    }
}

let container = AppDIContainer.shared

container.register(type: UserServiceProtocol.self, service: UserService())
container.register(type: RewardServiceProtocol.self, service: RewardService())

let viewModel = ViewModel()

viewModel.fetchUsers()
viewModel.fetchRewards()
