//
//  Order.swift
//  CupcakeCorner
//
//  Created by user on 7/15/24.
//
import SwiftUI

extension String {
    func onlyContainsWhitespaces() -> Bool {
        if self.contains(/[a-zA-Z0-9-]/) {
            return false
        }
        return true
    }
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            do {
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                type = decodedOrder.type
                quantity = decodedOrder.quantity
                specialRequestEnabled = decodedOrder.specialRequestEnabled
                extraFrosting = decodedOrder.extraFrosting
                addSprinkles = decodedOrder.addSprinkles
                name = decodedOrder.name
                streetAddress = decodedOrder.streetAddress
                city = decodedOrder.city
                zip = decodedOrder.zip
            } catch {
                print("Failed to decode order: \(error)")
            }
        }
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        } else if name.onlyContainsWhitespaces() || streetAddress.onlyContainsWhitespaces() || city.onlyContainsWhitespaces() || zip.onlyContainsWhitespaces() {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}

#Preview {
    CheckoutView(order: Order())
}
