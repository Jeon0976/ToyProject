import UIKit

enum Auth {
    case owner
    case guest
}

class Client {
    var auth: Auth
    
    init(_ auth: Auth) {
        self.auth = auth
    }
}

// Subject
protocol YouTubeDowloadSubject {
    func downloadYoutubeVideos() async -> [String]
}

// realSubject
final class RealSubject: YouTubeDowloadSubject {
    func downloadYoutubeVideos() async -> [String] {
        // 유튜브 서버에서 비디오를 다운로드하는 부분
        return []
    }
}

// proxy
// proxy는 캐싱을 구현하여 요청을 중간에서 컨트롤 할 수 있다.
// 또한 클라이언트의 권한에 따라 제어를 할 수도 있다.
final class Proxy: YouTubeDowloadSubject {
    // 진짜 요청을 받아서 처리하는 객체, 정말로 사용할때만 초기화하기 위하여 lazy
    private lazy var realSubject = RealSubject()
    
    // 캐싱 구현
    private var videoCache = [String]()
    
    // 클라이언트 권한 받음
    private var client: Client
    
    init(_ client: Client) {
        self.client = client
    }
    
    func downloadYoutubeVideos() async -> [String] {
        guard client.auth == .owner else {
            print("비디오를 다운로드할 권한이 없습니다.")
            return []
        }
        
        // 비디오 캐시가 비어있으면 실제 realSubject에 데이터 요청
        if videoCache.isEmpty {
            videoCache = await realSubject.downloadYoutubeVideos()
            return videoCache
        } else {
            // 비디오 캐시에 데이터가 있으면 리턴
            return videoCache
        }
    }
}

let client = Client(.owner)
let proxy = Proxy(client)

func loadYouTubeVideo(_ service: YouTubeDowloadSubject) {
    service.downloadYoutubeVideos()
}

loadYouTubeVideo(proxy)
