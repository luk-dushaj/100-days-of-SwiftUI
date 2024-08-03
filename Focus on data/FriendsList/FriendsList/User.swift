//
//  User.swift
//  FriendsList
//
//  Created by user on 7/29/24.
//

import Foundation

struct User: Hashable, Identifiable, Codable {
    let id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]

    static let example = User(id: UUID(), isActive: true, name: "Joe Smith", age: 27, company: "Google", email: "joesmith@gmail.com", address: "236, Random Adress Lane", about: "Joe is a backend engineer at Google.", registered: .now, tags: ["python", "django"], friends: [])
}
