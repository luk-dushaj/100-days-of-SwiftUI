//
//  Settings.swift
//  MultiplicationTables
//
//  Created by user on 6/23/24.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var data: Data
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Section("What table do you want to practice?") {
                Stepper("\(data.chosenNumber) tables", value: $data.chosenNumber, in: 2...12, step: 1)
            }

            Section("How many questions do you want?") {
                Picker("Questions", selection: $data.questions) {
                    ForEach([5, 10, 20], id: \.self) { questionIndex in
                        Text("\(questionIndex)")
                    }
                }
                .pickerStyle(.segmented)
            }

            Button("Done") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    Settings(data: Data)
}
