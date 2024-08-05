//
//  Friend.swift
//  FriendsList
//
//  Created by user on 7/29/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}
