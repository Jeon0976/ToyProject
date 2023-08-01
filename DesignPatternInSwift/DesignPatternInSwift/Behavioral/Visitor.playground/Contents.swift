import UIKit


protocol Tutor {
    func teach(student: YagomSchoolStudent)
    func teach(student: JostSchoolStudent)
}

extension Tutor {
    func teach(student: YagomSchoolStudent) {
        print("\(student.name), 공부하세요.!!!!")
    }

    func teach(student: JostSchoolStudent) {
        print("\(student.name), 넌 좀 쉬어")
    }
}

class MathTutor: Tutor { }

class EnglishTutor: Tutor { }

protocol Student {
    func receivePrivateLesson(tutor: Tutor)
}

class YagomSchoolStudent: Student {
    let name: String

    init(name: String) {
        self.name = name
    }

    func receivePrivateLesson(tutor: Tutor) {
        tutor.teach(student: self)
    }
}

class JostSchoolStudent: Student {
    let name: String

    init(name: String) {
        self.name = name
    }

    func receivePrivateLesson(tutor: Tutor) {
        tutor.teach(student: self)
    }
}

let yagom = YagomSchoolStudent(name: "yagom")
let jost = JostSchoolStudent(name: "jost")

let mathTutor = MathTutor()
yagom.receivePrivateLesson(tutor: mathTutor)
jost.receivePrivateLesson(tutor: mathTutor)

let englishTutor = EnglishTutor()
yagom.receivePrivateLesson(tutor: englishTutor)
jost.receivePrivateLesson(tutor: englishTutor)

// Element
protocol FileSystemElement {
    func accept(visitor: FileSystemVisitor)
}

// Concrete Elements
class File: FileSystemElement {
    var name: String

    init(name: String) {
        self.name = name
    }

    func accept(visitor: FileSystemVisitor) {
        visitor.visit(file: self)
    }
}

class Directory: FileSystemElement {
    var name: String
    var elements: [FileSystemElement]

    init(name: String, elements: [FileSystemElement]) {
        self.name = name
        self.elements = elements
    }

    func accept(visitor: FileSystemVisitor) {
        visitor.visit(directory: self)
    }
}

// Visitor
protocol FileSystemVisitor {
    func visit(file: File)
    func visit(directory: Directory)
}

// Concrete Visitors
class FileSearchVisitor: FileSystemVisitor {
    var keyword: String
    var foundFiles: [File] = []

    init(keyword: String) {
        self.keyword = keyword
    }

    func visit(file: File) {
        if file.name.contains(keyword) {
            foundFiles.append(file)
        }
    }

    func visit(directory: Directory) {
        for element in directory.elements {
            element.accept(visitor: self)
        }
    }
}

class FilePrintVisitor: FileSystemVisitor {
    func visit(file: File) {
        print("File: \(file.name)")
    }

    func visit(directory: Directory) {
        print("Directory: \(directory.name)")
        for element in directory.elements {
            element.accept(visitor: self)
        }
    }
}

// Usage
let fileSystem = Directory(name: "root", elements: [
    File(name: "file1"),
    Directory(name: "dir1", elements: [
        File(name: "file2"),
        File(name: "file3"),
    ]),
    File(name: "file4"),
])

let fileSearchVisitor = FileSearchVisitor(keyword: "file")
fileSystem.accept(visitor: fileSearchVisitor)
print("Found files: \(fileSearchVisitor.foundFiles.map { $0.name })")  // Prints: ["file1", "file2", "file3", "file4"]

let filePrintVisitor = FilePrintVisitor()
fileSystem.accept(visitor: filePrintVisitor)  // Prints all files and directories

// Element
protocol NotificationElement {
    func accept(visitor: NotificationVisitor)
}

// Concrete Elements
class MessageNotification: NotificationElement {
    var message: String

    init(message: String) {
        self.message = message
    }

    func accept(visitor: NotificationVisitor) {
        visitor.visit(messageNotification: self)
    }
}

class FriendRequestNotification: NotificationElement {
    var username: String

    init(username: String) {
        self.username = username
    }

    func accept(visitor: NotificationVisitor) {
        visitor.visit(friendRequestNotification: self)
    }
}

// Visitor
protocol NotificationVisitor {
    func visit(messageNotification: MessageNotification)
    func visit(friendRequestNotification: FriendRequestNotification)
}

// Concrete Visitors
class AlertNotificationVisitor: NotificationVisitor {
    func visit(messageNotification: MessageNotification) {
        print("Alert: You have a new message: \(messageNotification.message)")
    }

    func visit(friendRequestNotification: FriendRequestNotification) {
        print("Alert: You have a new friend request from \(friendRequestNotification.username)")
    }
}

class BadgeNotificationVisitor: NotificationVisitor {
    var badgeCount = 0

    func visit(messageNotification: MessageNotification) {
        badgeCount += 1
    }

    func visit(friendRequestNotification: FriendRequestNotification) {
        badgeCount += 1
    }
}

// Usage
let notifications: [NotificationElement] = [
    MessageNotification(message: "Hello, world!"),
    FriendRequestNotification(username: "johndoe"),
]

let alertNotificationVisitor = AlertNotificationVisitor()
let badgeNotificationVisitor = BadgeNotificationVisitor()

for notification in notifications {
    notification.accept(visitor: alertNotificationVisitor)  // Alerts for each notification
    notification.accept(visitor: badgeNotificationVisitor)  // Updates badge count for each notification
}

print("Badge count: \(badgeNotificationVisitor.badgeCount)")  // Prints: 2
