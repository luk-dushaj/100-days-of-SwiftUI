import UIKit

/*
 Directions:
 
 Now that you understand a little about optionals, it’s time to pause for a few minutes and try a small coding challenge so you can see how much you’ve remembered.

 Your challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.

 If that sounds easy, it’s because I haven’t explained the catch yet: I want you to write your function in a single line of code. No, that doesn’t mean you should just write lots of code then remove all the line breaks – you should be able to write this whole thing in one line of code.

 I’ll provide some hints in a moment, but first I recommend you go ahead and try it yourself.
 */


func acceptArray(_ array : [Int]?) -> Int { return array?.randomElement() ?? Int.random(in: 1...100) }

var empty: [Int]?

var array: [Int]? = [1, 2, 3, 4, 5]

print(acceptArray(array))

print(acceptArray(empty))
