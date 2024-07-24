//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by user on 7/23/24.
//

import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
