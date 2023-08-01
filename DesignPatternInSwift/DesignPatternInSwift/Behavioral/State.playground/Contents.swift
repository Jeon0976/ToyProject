import UIKit

// Context
class Light {
    var state: State

    init(lightState: State) {
        self.state = lightState
    }

    func changeStateToOn() {
        print("--Pushed On Button--")
        state.onButtonPushed()
        state = TurnOnState()
    }

    func changeStateOff() {
        print("--Pushed Off Button--")
        state.offButtonPuhsed()
        state = TurnOffState()
    }
}


// State Interface
protocol State {
    func onButtonPushed()
    func offButtonPuhsed()
}


// Concrete State
class TurnOnState: State {
    func onButtonPushed() {
        print("Already Turn On Button Pushed.")
    }

    func offButtonPuhsed() {
        print("Turn Off Light")
    }


}


class TurnOffState: State {
    func onButtonPushed() {
        print("Turn On Light")
    }

    func offButtonPuhsed() {
        print("Already Turn Off Button Pushed.")
    }
}

let light = Light(lightState: TurnOffState())
light.changeStateToOn()
light.changeStateToOn()
light.changeStateOff()


// State Interface
protocol CharacterState {
    func attack()
    func defend()
    func rest()
}

// Concrete State
class RestingState: CharacterState {
    func attack() {
        print("휴식 중입니다. 공격을 시작하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("공격 상태로 전환합니다.")
            Character.shared.changeState(state: AttackingState())
        }
    }

    func defend() {
        print("휴식 중입니다. 방어를 시작하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("방어 상태로 전환합니다.")
            Character.shared.changeState(state: DefendingState())
        }
    }

    func rest() {
        print("이미 휴식 중입니다.")
    }
}

class AttackingState: CharacterState {
    func attack() {
        print("계속 공격하시겠습니까? (y/n)")
        if readLine() != "y" {
            print("휴식 상태로 전환합니다.")
            Character.shared.changeState(state: RestingState())
        }
    }

    func defend() {
        print("공격에서 방어로 전환하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("방어 상태로 전환합니다.")
            Character.shared.changeState(state: DefendingState())
        }
    }

    func rest() {
        print("공격 중단하고 휴식하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("휴식 상태로 전환합니다.")
            Character.shared.changeState(state: RestingState())
        }
    }
}

class DefendingState: CharacterState {
    func attack() {
        print("방어에서 공격으로 전환하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("공격 상태로 전환합니다.")
            Character.shared.changeState(state: AttackingState())
        }
    }

    func defend() {
        print("계속 방어하시겠습니까? (y/n)")
        if readLine() != "y" {
            print("휴식 상태로 전환합니다.")
            Character.shared.changeState(state: RestingState())
        }
    }

    func rest() {
        print("방어를 중단하고 휴식하시겠습니까? (y/n)")
        if readLine() == "y" {
            print("휴식 상태로 전환합니다.")
            Character.shared.changeState(state: RestingState())
        }
    }
}

// Context
class Character {
    static let shared = Character(state: RestingState())
    var state: CharacterState

    private init(state: CharacterState) {
        self.state = state
    }

    func attack() {
        state.attack()
    }

    func defend() {
        state.defend()
    }

    func rest() {
        state.rest()
    }

    func changeState(state: CharacterState) {
        self.state = state
    }
}


let character = Character.shared

character.attack()

