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
    @State private var questions = 5
    @State private var questionNumber = 1
    @State private var endGame = false
    @State private var score = 0
    @State private var showingScore = false
    @State private var answer: Int?
    @State private var scoreTitle = ""
    @State private var isGameActive = false
    @State private var focused = false
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
                    ForEach(questionOptions, id: \.self) { questionIndex in
                        Text("\(questionIndex)")
                    }
                }
                
                .pickerStyle(.segmented)
            }
            
            
            VStack {
                TextField("Answer", value: $userAnswer, formatter: NumberFormatter())
                
                Button("Submit") {
                    controlFlow(userAnswer)
                    showingScore = true
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: {
                    showingScore = false
                    // Optionally reset userAnswer and increment questionNumber here
                })
            }
            
            
            
            
            Text("What is \(chosenNumber) * \(number)?")
            Text("Question: \(questionNumber)/\(questions)")
            Text("Score: \(score)/\(questions)")
            
        }
    }
    //            .navigationTitle("Times Tables")
    
    func multiply(chosenNumber: Int, number: Int) -> Int { chosenNumber * number }
    
    func controlFlow(_ userAnswer: Int){
        print("running")
        guard questionNumber < questions else {
            print("hell no")
            endGame = true
            return
        }
        answer = multiply(chosenNumber: chosenNumber, number: number)
        
        if userAnswer == answer {
            score += 1
            scoreTitle = "Good"
        } else {
            scoreTitle = "Bad"
        }
        
        nextQuestion()
        
    }
    
    func nextQuestion() {
            questionNumber += 1
            number = Int.random(in: 2..<12)
            userAnswer = 0
            showingScore = false
        }
}


#Preview {
    ContentView()
}
