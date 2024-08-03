//
//  Friend.swift
//  FriendsList
//
//  Created by user on 7/29/24.
//

import Foundation

struct Friend: Hashable, Identifiable, Codable {
    let id: UUID
    var name: String
}
