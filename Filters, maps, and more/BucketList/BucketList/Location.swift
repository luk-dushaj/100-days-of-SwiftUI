//
//  Location.swift
//  BucketList
//
//  Created by user on 8/14/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    // means won't get compiled to release build for app store only stored in xcode
    #if DEBUG
    static let example = Location(id: UUID(), name: "Miami", description: "The sunny state", latitude: 25.7617, longitude: 80.1918)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
