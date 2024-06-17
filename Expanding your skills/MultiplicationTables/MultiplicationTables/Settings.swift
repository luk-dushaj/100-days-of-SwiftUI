//
//  SwiftUIView.swift
//  MultiplicationTables
//
//  Created by user on 6/17/24.
//

import SwiftUI

struct Settings: View {
    let questionOptions = [5, 10, 20]
    @State private var number = Int.random(in: 2..<12)
    @State private var questions = 0
    @State private var questionNumber = 1
    @State private var chosenNumber = 2
    var body: some View {
        Section("What table do you want to practice?"){
            Stepper("\(chosenNumber) tables", value: $chosenNumber, in: 2...12, step: 1)
        }
        
        Section("How much questions do you want?"){
            Picker("Questions", selection: $questions){
                ForEach(questionOptions.indices, id: \.self) { questionIndex in
                    Text("\(questionOptions[questionIndex])")
                }
            }
            
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    Settings()
}
