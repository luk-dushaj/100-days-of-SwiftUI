import UIKit

/*
 Directions:
 
 Structs sit at the core of every SwiftUI app, so it’s really important you take some extra time to make sure you understand what they do and how they work.

 To check your knowledge, here’s a small task for you: create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?

 As always I’ll write some hints below, but first I’m going to leave some space so you don’t see the hints by accident. As always, it’s a really good idea to try this challenge yourself before looking at the hints – it’s the fastest way to identify parts you feel less confident with.
 */

struct Car {
    public let model : String
    public let seats : Int
    private(set) var gear : Int
    
    init(model: String, seats: Int, gear: Int) {
        self.model = model
        self.seats = seats
        self.gear = gear
    }
    
    mutating func changeGear(_ speed: Int) {
        if speed > 0 && speed <= 10 {
            gear = speed
        } else {
            print("Invalid gear.")
        }
    }
}

var car = Car(model: "Tesla", seats: 4, gear: 5)

car.changeGear(8)

print(car)

/*
 I implemented the gears part incorrectly before the hints because I thought he was referring to the car driving and not driving at first.
 But after what I saw what he wanted for gears I implemented the logic correctly.
 */
