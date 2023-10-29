//
//  Coordinator.swift
//  Coordinator
//
//  Created by 전성훈 on 2023/10/29.
//

import UIKit

// MARK: Coordinator
protocol Coordinator: AnyObject {
    // 자신을 완료했다고 부모 코디네이터에게 알리기 위한 델리게이트
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    // 각 코디네이터에게 할당된 하나의 navigation controller
    var navigationController: UINavigationController { get set }
    // 모든 자식 코디네이터를 추적하기 위한 배열, 대부분의 경우 이 배열은 하나의 자식 코디네이터만 포함
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    // 플로우를 시작하기 위한 로직을 넣는 곳
    func start()
    // 플로우를 마치기 위한 로직을 넣는 곳, 모든 자식 코디네이터를 정리하고, 자신이 deallocate 될 준비가 되었다는 것을 부모에게 알리는 곳
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        // 모든 자식 코디네이터를 제거
        childCoordinators.removeAll()
        // 부모 코디네이터에게 자신이 완료되었음을 알림
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// 자식 코디네이터가 완료되어 제거될 준비가 되었음을 부모 코디네이터에게 알리기 위한 델리게이트 프로토콜
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// 플로우 타입 정의
enum CoordinatorType {
    case app, login, tab
}
