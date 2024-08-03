//
//  Detail.swift
//  HabitTracker
//
//  Created by user on 7/7/24.
//

import SwiftUI

struct Detail: View {
    @Bindable var habit: Habit
    @Binding var isChanged: Bool
    
    var body: some View {
        Group {
            Section {
                VStack {
                    Text("Description: ")
                        .font(.title3)
                    Text("\(habit.description)")
                }
            }
            .padding()
            Section {
                HStack {
                    Text("Times Completed: \(habit.timesCompleted)")
                        .font(.title3)
                    Button {
                        habit.timesCompleted += 1
                        isChanged = true
                    } label: {
                        Label("", systemImage: "plus")
                    }
                }
            }
        }
    }
}
#Preview {
    Detail(habit: Habit(), isChanged: .constant(false))
}
