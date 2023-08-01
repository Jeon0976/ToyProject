import UIKit

protocol AbstractExpression {
    func interpret(_ context: Context)
}

final class Context {
    enum Gender {
        case male
        case female
    }
    
    private var persons: [String: Gender] = [:]
    
    func getPersons() -> [String: Gender] {
        self.persons
    }
    
    func lookup(name: String) -> Gender {
        return self.persons[name]!
    }
    
    func assign(expresion: TerminalExpression, gender: Gender) {
        self.persons[expresion.name] = gender
    }
}

final class TerminalExpression: AbstractExpression {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func interpret(_ context: Context) {
        print(context.lookup(name: self.name))
    }
}

final class NonterminalExpression: AbstractExpression {
    private var maleCount: Int = 0
    private var femaleCount: Int = 0
    
    func interpret(_ context: Context) {
        for person in context.getPersons() {
            if person.value == .male {
                maleCount += 1
            } else if person.value == .female {
                femaleCount += 1
            }
        }
        print("남자는 \(maleCount)명, 여자는 \(femaleCount)명")
    }
}

let context = Context()
let a = TerminalExpression(name: "전성훈")
let b = TerminalExpression(name: "Dwd")

context.assign(expresion: a, gender: .male)
context.assign(expresion: b, gender: .female)

let expression = NonterminalExpression()
expression.interpret(context)
