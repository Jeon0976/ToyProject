//: [Previous](@previous)
import Foundation

//: ## 플레이그라운드 vs 실제 앱 (주의)
//: 실제 앱에서는 UI관련작업들이 `DispatchQueue.main`(메인큐)에서 동작하지만, 플레이 그라운드에서는 `DispatchQueue.global()`(글로벌 디폴트큐)에서 동작한다. 따라서 플레이그라운드에서는 메인큐에 일을 시키면 안된다.
//:
// DispatchQueue.main ====> 앱에서는 UI를 담당
// DispatchQueue.global() ====> 플레이그라운드에서 프린트영역를 담당
//: [Next](@next)
