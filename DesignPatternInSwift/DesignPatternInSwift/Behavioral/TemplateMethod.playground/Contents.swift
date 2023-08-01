import Foundation

class SteakMaker {
    final func makeSteak() {
        grill()
        pourSauce()
        plating()
        print("----")
    }
    
    func grill() {
        print("고기를 굽습니다.")
    }
    
    func pourSauce() {
        print("소스를 붓습니다.")
    }
    
    func plating() {
        print("플레이팅 합니다.")
    }
}

class ChefOdong: SteakMaker {
    override func grill() {
        print("레어로 굽습니다.")
    }
}

let steakMaker = SteakMaker()
let odong = ChefOdong()

steakMaker.makeSteak()
odong.makeSteak()
