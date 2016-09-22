//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let classCapacity = 21
var classNumber = 2

var price: Double = 2.0

func someFunc(price: Double, name: String) -> Double {
    return price
}

if price < 0 {
    print("Price: \(price) cannot be negative")
} else {
    
}

var myOldInt: NSInteger = 0
var myNewInt: Int = 0

var myOldFloat: CGFloat = 1.1
var myNewFloat: Double = 1.1

var array = [3, 5, 2, 4]
array.remove(at:2)

func returnStuff() -> [Int: Double] {
    var ret = [Int: Double]()
    
    ret[0] = 1.1
    ret[3] = 4.3
    
    return ret
}
