import UIKit

//typealias FeedLoader = (([String]) -> Void) -> Void

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { loadedItems in
            // update UI
        }
    }
}
 
// leaf
class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        print("remote")
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        print("local")
    }
}

struct Reachability {
    static let networkAvailable = false
}
// Composite
// concrete type은 최대한 밖으로 빼기
class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // if문을 위 struct 변수를 활용하여 훨씬 더 간단하게 코드 작성
//        if Reachability.networkAvailable {
//            remote.loadFeed { loadedItems in
//                // do something
//            }
//        } else {
//            local.loadFeed { loadedItems in
//                // do something
//            }
//        }
        
        let load = Reachability.networkAvailable ? remote.loadFeed : local.loadFeed
        
        load(completion)
    }
}

let vc = FeedViewController(loader: RemoteFeedLoader())
let vc2  = FeedViewController(loader: LocalFeedLoader())
let vc3 = FeedViewController(loader: RemoteWithLocalFallbackFeedLoader(remote: RemoteFeedLoader(), local: LocalFeedLoader()))
vc3.loader.loadFeed { items in
    
}
