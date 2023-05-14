/*:

# GCD 이해하기
[Grand Central Dispatch](https://developer.apple.com/documentation/DISPATCH)

### 1.GCD/Operation에 앞서
* 1.Preview - 들어가기에 앞서
* 1-1.SimpleExample - 간단한 예제
* 1-2.AsyncVsSync - 비동기와 동기의 비교
---
### 2.디스패치큐(GCD)의 종류와 특성
* 2.GCD-Queues
---
### 3.디스패치큐(GCD) 사용시 주의해야할 사항
* 3.Caution - 플레이그라운드 사용시 주의사항
* 3-1.UI-update - 반드시 메인큐에서 처리해야하는 작업
* 3-2.SyncMethod - sync메서드에 대한 주의 사항
* 3-5.SyncToAsync - 동기적 함수를 비동기함수 처럼 만드는 방법
---
### 4.디스패치 그룹
* 4.DispatchGroup - 디스패치 그룹
* 4-1.GroupAnimationExample - 애니메이션 예제
* 4-2.AsyncDispatchGroup - 비동기 디스패치 그룹
* 4-2.GroupAnimationExample - 애니메이션을 활용한 디스패치 그룹 예제
* 4-2.AnotherExample - 또다른 비동기 디스패치 그룹 예제
* 4-3.DispatchWorkItem - (참고) 디스패치 워크아이템
* 4-4.DispatchSemaphore - (심화) 디스패치 세마포어
---
### 6.(심화)동시성과 관련된 문제
* 6-1.RaceCondition - 경쟁상황 예시
* 6-1.AnotherRaceCondition - 경쟁 상황 예시2
* 6-3.PriorityInversion - 우선순위의 뒤바뀜
---
### 7.(심화)Thread-safe한 코드의 구현과 방법
* 7-2.SerialQueueSync - 시리얼큐와 Sync메서드의 사용
* 7-3.DispatchBarrier - 디스패치 배리어(Barrier) 작업
---
### 8.(심화)Lazy Var와 관련된 이슈의 처리방법
* 8.LazyVar - Lazy Var와 관련된 이슈들
*/

//: [Next](@next)
