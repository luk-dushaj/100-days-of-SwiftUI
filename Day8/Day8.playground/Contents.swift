//import UIKit

// Problem below:

/*
 With functions under your belt, it’s time to try a little coding challenge. Don’t worry, it’s not that hard, but it might take you a while to think about and come up with something. As always I’ll be giving you some hints if you need them.

 The challenge is this: write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:

 You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
 If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
 You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
 If you can’t find the square root, throw a “no root” error.
 As a reminder, if you have number X, the square root of X will be another number that, when multiplied by itself, gives X. So, the square root of 9 is 3, because 3x3 is 9, and the square root of 25 is 5, because 5x5 is 25.

 I’ll give you some hints in a moment, but as always I encourage you to try it yourself first – struggling to remember how things work, and often having to look them up again, is a powerful way to make progress.
 */

// Solution:

enum sqrtError: Error {
    case outOfBounds, noRoot
}

func getSqrt(_ number: Int) throws -> Int {
    if number >= 1 && number <= 1000 {
        for i in 1...100 {
            let result = i * i
            if result == number {
                return i
            }
        }
        throw sqrtError.noRoot
    } else {
        throw sqrtError.outOfBounds
    }
}

do {
    let result = try getSqrt(25)
    print(result)
} catch {
    print("Error: \(error)")
}

// I did solve it but granted with the hints
