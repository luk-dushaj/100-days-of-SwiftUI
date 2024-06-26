//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by user on 6/3/24.
//

import SwiftUI

class Data: ObservableObject {
    @Published var chosenNumber: Int
    @Published var questions: Int

    init(chosenNumber: Int = 2, questions: Int = 5) {
        self.chosenNumber = chosenNumber
        self.questions = questions
    }
}


struct ContentView: View {
    
    @ObservedObject private var data = Data()
    @State private var number = Int.random(in: 2..<12)
    @State private var endGame = false
    @State private var score = 0
    @State private var showingScore = false
    @State private var answer: Int?
    @State private var scoreTitle = ""
    @State private var settingsView = true
    @State private var focused = false
    @State private var questionNumber = 1
    @State private var userAnswer = 0
    
    var body: some View {
        VStack {
            Text("Times Tables")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            Button("Settings") {
                settingsView.toggle()
            }
            .sheet(isPresented: $settingsView) {
                Settings(data: data)
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
                    nextQuestion()
                })
            }
            
            if !endGame {
                Text("What is \(data.chosenNumber) * \(number)?")
                Text("Question: \(questionNumber)/\(data.questions)")
                Text("Score: \(score)/\(data.questions)")
            } else {
                Text("The game has ended. Final score: \(score)/\(data.questions)")
            }
            
            Spacer()
        }
    }
    
    func multiply(chosenNumber: Int, number: Int) -> Int {
        chosenNumber * number
    }
    
    func controlFlow(_ userAnswer: Int) {
        answer = multiply(chosenNumber: data.chosenNumber, number: number)
        
        if userAnswer == answer {
            score += 1
            scoreTitle = "Good"
        } else {
            scoreTitle = "Bad"
        }
        
        if questionNumber == data.questions {
            endGame = true
        } else {
            questionNumber += 1
        }
    }
    
    func nextQuestion() {
        number = Int.random(in: 2..<12)
        userAnswer = 0
        showingScore = false
    }
}


#Preview {
    ContentView()
}
