//
//  Detail.swift
//  HabitTracker
//
//  Created by user on 7/7/24.
//

import SwiftUI

struct Detail: View {
    @Binding var habit: Habit
    @Binding var saveTimesCompleted: Bool
    
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
                        saveTimesCompleted = true
                    } label: {
                        Label("", systemImage: "plus")
                    }
                }
            }
        }
    }
}
#Preview {
    Detail(habit: .constant(Habit()), saveTimesCompleted: .constant(false))
}
