import UIKit

var greeting = "Hello, playground"


let test:[String] = ["1","2","3"]
let test2: String = "3"

test.filter{ string in
    string != test2
}
