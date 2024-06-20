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
    @State private var settingsView = true
    @State private var focused = false
    // type has to be string for answer because Textfield enforces it
    @State private var userAnswer = 0
    let questionOptions = [5, 10, 20]
    
    var body: some View {
        
        Text("Times Tables")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
        Spacer()
        
            .sheet(isPresented: $settingsView) {
                
                
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
                    Button("Done"){
                        settingsView.toggle()
                    }
                }
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
        .alert("The game has ended. Final score: \(score)/\(questions)",isPresented: $endGame) {
            Button("Restart", action: {
                endGame.toggle()
                restartGame()
            })
            Button("Play Again", action: {
                endGame.toggle()
                settingsView.toggle()
                restartGame()
            })
        }
        
        
        
        
        Text("What is \(chosenNumber) * \(number)?")
        Text("Question: \(questionNumber)/\(questions)")
        Text("Score: \(score)/\(questions)")
        Spacer()
    }
    
    
    //            .navigationTitle("Times Tables")
    
    func multiply(chosenNumber: Int, number: Int) -> Int { chosenNumber * number }
    
    func controlFlow(_ userAnswer: Int){
        
        answer = multiply(chosenNumber: chosenNumber, number: number)
        
        if userAnswer == answer {
            score += 1
            scoreTitle = "Good"
        } else {
            scoreTitle = "Bad"
        }
        
        if questionNumber == 5 {
            endGame.toggle()
            return
        }
        
        questionNumber += 1
        
        nextQuestion()
        
    }
    
    func nextQuestion() {
        number = Int.random(in: 2..<12)
        userAnswer = 0
        showingScore = false
    }
    
    func restartGame() {
        nextQuestion()
        questionNumber = 0
        score = 0
    }
}


#Preview {
    ContentView()
}
