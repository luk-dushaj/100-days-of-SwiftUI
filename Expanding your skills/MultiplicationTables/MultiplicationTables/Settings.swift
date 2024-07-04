//
//  Settings.swift
//  MultiplicationTables
//
//  Created by user on 6/23/24.
//

import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    @Binding var chosenNumber: Int
    @Binding var questions: Int
    @Binding var settingsView: Bool
    
    var body: some View {
        VStack {
            Section(header: Text("What table do you want to practice?").font(.system(size: 18))) {
                Stepper("\(chosenNumber) tables", value: $chosenNumber, in: 2...12, step: 1)
                    .font(.system(size: 18))
            }
            
            Section(header: Text("How many questions do you want?").font(.system(size: 18))) {
                Picker("Questions", selection: $questions) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Button("Done") {
                settingsView.toggle()
                dismiss()
            }
            .foregroundColor(.green)
            .frame(width: 75, height: 50)
            .background(.white)
            .clipShape(.rect(cornerRadius: 30))
        }
        .padding()
    }
}

#Preview {
    Settings(chosenNumber: .constant(2), questions: .constant(5), settingsView: .constant(true))
}
