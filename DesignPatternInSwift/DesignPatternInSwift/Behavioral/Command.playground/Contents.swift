import UIKit

// Command
protocol Command {
    func execute()
}

// Concrete Command
struct turnOnTVCommand: Command {
    private var tv: TV // Receiver
    
    init(tv: TV) {
        self.tv = tv
    }
    
    func execute() {
        tv.turnOn()
    }
}

struct changeChannelCommand: Command {
    private var tv: TV // Receiver
    private var channel: String
    
    init(tv: TV, channel: String) {
        self.tv = tv
        self.channel = channel
    }
    
    func execute() {
        tv.change(channel)
    }
}

// Receiver
struct TV {
    func turnOn() {
        print("TV가 켜졌습니다.")
    }
    
    func change(_ channel: String) {
        print("TV \(channel)번 채널을 틀었습니다.")
    }
}

// Invoker
final class HomeApp {
    private var redButton: Command?
    private var numberButton: Command?
    
    func setCommand(redButton: Command, numberButton: Command) {
        self.redButton = redButton
        self.numberButton = numberButton
    }
    
    func pressRedButton() {
        // Command execute() 호출
        redButton?.execute()
    }
    
    func pressNumberButton() {
        numberButton?.execute()
    }
}

let homeApp = HomeApp()
let newTV = TV()
let turnOnTV = turnOnTVCommand(tv: newTV)
let changeChannelOfTV = changeChannelCommand(tv: newTV, channel: "14")

homeApp.setCommand(redButton: turnOnTV, numberButton: changeChannelOfTV)

homeApp.pressRedButton()
homeApp.pressNumberButton()
