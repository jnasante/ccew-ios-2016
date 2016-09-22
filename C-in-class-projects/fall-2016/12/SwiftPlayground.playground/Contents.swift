//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let str1 = "permanent"

var string = "FDF"

var string1:String

var artr = 7.0
var asf = 7

print("Your test score was: " + String(99))

let testScore = 100
var curve = 5
print("Your test score was: \(testScore + curve)")


var someArray = ["1", "2", "3"]

var stringArray:[String]
var imtiredofnamingarrays = [String]()
var someArray1 = []

someArray.append("4")

var dict = ["key": "value"]
dict["key"] = "otherValue"
dict["key2"] = "2"
var someDict = [:]

var optionalString: String? = "Hello"
print(optionalString == nil)

print(testScore is Int)

if let myString = optionalString {
    print(myString)
}

print("Optional string is: \(optionalString ?? "blah")")

let vegetable = "red pepper"
switch (vegetable) {
case let x where x.hasSuffix("pepper"):
    print("blah")
default:
    print("ugh")
}

for item in someArray1 {
    print(item)
}

for i in 0...4 {
    
}

var i = 5
while i < 5 {
    
}

if i < 5 {
    
}

repeat {
    
}while i < 5