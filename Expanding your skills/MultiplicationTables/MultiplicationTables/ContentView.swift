//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by user on 6/3/24.
//

import SwiftUI

struct ContentView: View {
      
    @State private var chosenNumber = 2
    @State private var number = Int.random(in: 2..<12)
    @State private var questions = 0
    @State private var questionNumber = 1
    // type has to be string for answer because Textfield enforces it
    @State private var answer = ""
    let questionOptions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            Text("Question: \(chosenNumber) * \(number)")
            
            
                Section("What table do you want to practice?"){
                    Stepper("\(chosenNumber) tables", value: $chosenNumber, in: 2...12, step: 1)
                }
                
                Section("How much questions do you want?"){
                    Picker("Questions", selection: $questions){
                        ForEach(questionOptions.indices) { question in
                            Text("\(questionOptions[question])")
                        }
                    }
                    .pickerStyle(.segmented)
                
                    
                    TextField("Answer", text: $answer)
            }
        }
        .navigationTitle("Times Tables")
    }
    func multiply(chosenNumber: Int, number: Int) -> Int { chosenNumber * number }

    func generate(){
        guard questionNumber > questions else {
            questionNumber += 1
            return
        }
        number = Int.random(in: 2..<12)
    }
}

#Preview {
    ContentView()
}
