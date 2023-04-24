import UIKit

var greeting = "Hello, playground"


var nums = [1,2,3,4]

for var num in nums {
    print(num)
    if num == 2 {
        num = 2
    }
}
print(nums)

let numberIndices = nums.indices

let filtered = numberIndices.filter { nums[$0] == 3 }

filtered.forEach { nums[$0] = 2 }
print(nums)
