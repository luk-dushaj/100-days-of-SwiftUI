//
//  AddHabit.swift
//  HabitTracker
//
//  Created by user on 7/5/24.
//

import SwiftUI

struct AddHabit: View {
    @Bindable var habit: Habit
    @Binding var isCreated: Bool
    @Environment(\.dismiss) var dismiss
    @State private var error = false
    var body: some View {
        Text("Add a Habit")
            .font(.title)
        Form {
            Section {
                VStack {
                    TextField("Title", text: $habit.title)
                    TextField("Description", text: $habit.description)
                }
            }
            
            Button("Cancel") {
                isCreated = false
                dismiss()
            }
//            .frame(maxWidth: .infinity)
            
            Button("Save") {
                isCreated = checkValues()
            }
//            .frame(maxWidth: .infinity)
            .alert("You left one of the fields empty.", isPresented: $error) {
                Button("Try again") {
                    error.toggle()
                }
                
            }
        }
    }
    func checkValues() -> Bool {
        if habit.title.isEmpty || habit.description.isEmpty {
            error.toggle()
            return false
        } else {
            dismiss()
            return true
        }
    }
}

#Preview {
    AddHabit(habit: Habit(), isCreated: .constant(false))
}
