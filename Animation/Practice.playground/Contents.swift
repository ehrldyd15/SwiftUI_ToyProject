import UIKit

func swapNumber(first: inout Int, second: inout Int) {
    var temp = first
    first = second
    second = temp
}

var a = 10
var b = 20

print("\(a) : \(b)")

swapNumber(first: &a, second: &b)
print("\(a) : \(b)")
