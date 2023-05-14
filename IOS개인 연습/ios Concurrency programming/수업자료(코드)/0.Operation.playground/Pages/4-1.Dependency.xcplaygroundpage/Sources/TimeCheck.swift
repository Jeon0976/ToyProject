import Foundation

public func timeCheck(_ block: () -> ()) -> TimeInterval {
    let start = Date()
    block()
    return Date().timeIntervalSince(start)
}
