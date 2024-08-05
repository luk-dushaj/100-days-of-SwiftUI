//
//  FriendsListApp.swift
//  FriendsList
//
//  Created by user on 7/29/24.
//

import SwiftUI
import SwiftData

@main
struct FriendsListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
