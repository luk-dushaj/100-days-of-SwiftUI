import UIKit

/*
 Directions:
 
Now that you understand how classes work, and, just as importantly, how they are different from structs, it’s time to tackle a small challenge to check your progress.

Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.

But there’s more:

The Animal class should have a legs integer property that tracks how many legs the animal has.
The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
The Cat class should have a matching speak() method, again with each subclass printing something different.
The Cat class should have an isTame Boolean property, provided using an initializer.
I’ll provide some hints in a moment, but first I recommend you go ahead and try it yourself.
*/


class Animal {
    var legs: Int // Changed from public to var
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {}
}

class Cat: Animal {
    var isTame: Bool
    init(legs: Int = 4, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    override func speak() {
        print("meow")
    }
}

class Dog: Animal {
    override init(legs: Int = 4) {
        super.init(legs: legs)
    }
    override func speak() {
        print("bark")
    }
}

class Corgi : Dog {
    override func speak() {
        print("rawf")
    }
}

class Poodle : Dog {
    override func speak() {
        print("woof")
    }
    
}

class Persian : Cat {
    override func speak() {
        print("rawr")
    }
}

class Lion : Cat {
    override func speak() {
        print("roar")
    }
}

var lion = Lion(isTame: false)
lion.speak()
