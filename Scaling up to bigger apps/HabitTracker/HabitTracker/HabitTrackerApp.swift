//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by user on 7/4/24.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(habit: Habit())
        }
    }
}
