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
    @State private var endGame = false
    @State private var score = 0
    @State private var showingScore = false
    @State private var answer = 0
    @State private var scoreTitle = ""
    // type has to be string for answer because Textfield enforces it
    @State private var userAnswer = 0
    let questionOptions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            
            
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
                
                
                TextField("Answer", value: $userAnswer, formatter: NumberFormatter())
                    .alert(scoreTitle, isPresented: $showingScore){
                        Button("Continue", action: {
                            showingScore = false
                        })
                    } message: {
                        Text(scoreTitle)
                    }
                
                
                
                
                Text("What is \(chosenNumber) * \(number)?")
                Text("Question: \(questionNumber)/\(questions)")
                Text("Score: \(score)/\(questions)")
                
                    .onSubmit {
                        controlFlow(userAnswer)
                    }
                
            }
        }
        .navigationTitle("Times Tables")
    }
    func multiply(chosenNumber: Int, number: Int) -> Int { chosenNumber * number }
    
    func controlFlow(_ userAnswer: Int){
        guard questionNumber > questions else {
            endGame = true
            return
        }
        
        answer = multiply(chosenNumber: chosenNumber, number: number)
        
        if userAnswer == answer {
            score += 1
            showingScore = true
            scoreTitle = "Good"
        } else {
            showingScore = true
            scoreTitle = "Bad"
        }
        
    }
    
}

#Preview {
    ContentView()
}
