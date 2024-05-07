import UIKit

/*
 Directions:
 
 Now that you understand how protocols and extensions work, it’s time to pause our learning and take on a challenge so you can put it all into practice.

 Your challenge is this: make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

 A property storing how many rooms it has.
 A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
 A property storing the name of the estate agent responsible for selling the building.
 A method for printing the sales summary of the building, describing what it is along with its other properties.
 */

protocol Building {
    var rooms : Int {get }
    var cost : Int {get }
    var agent : String {get }
    func salesSummary()
}

extension Building {
    func salesSummary(){
        print("This building is a \(type(of: self))")
        print("Building has \(rooms) rooms")
        print("The building costs $\(cost)")
        print("The agent who sold it is \(agent)")
    }
}

struct House : Building {
    let rooms : Int
    let cost : Int
    let agent : String
}

struct Office : Building {
    let rooms : Int
    let cost : Int
    let agent : String
}

let office = Office(rooms: 5, cost: 500_000, agent: "Jimmy Smith")

office.salesSummary()
