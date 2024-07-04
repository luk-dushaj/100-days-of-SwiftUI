//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by user on 6/3/24.
//
import SwiftUI

struct CustomRoundedBorderTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.black, lineWidth: 3)
                    .frame(height: 50)
            )
            .padding(.horizontal)
    }
}

struct CustomFontSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
    }
}

struct CustomButtonStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .background(.white)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
    }
}

extension View {
    func customFontSize() -> some View {
        self.modifier(CustomFontSizeModifier())
    }
    func customButtonStyle(color: Color) -> some View {
        self.modifier(CustomButtonStyle(color: color))
    }
}

struct ContentView: View {
    @State private var chosenNumber: Int = 2
    @State private var questions: Int = 5
    @State private var number = Int.random(in: 2..<12)
    @State private var endGame = false
    @State private var earlyEnd = false
    @State private var score = 0
    @State private var answer: Int?
    @State private var settingsView = true
    @State private var questionNumber = 1
    @State private var userAnswer = ""
    @State private var angle: Double = 0
    var colors: [Color] = [.red, .blue, .green, .purple, .orange, .brown, .yellow, .pink, .cyan, .mint, .indigo, .teal]
    var animations: [Animation] = [.bouncy, .easeInOut, .smooth, .snappy]
    @State private var animation: Animation = .bouncy
    @State private var color: Color = .blue
    
    var body: some View {
        ZStack {
            VStack {
                Text("Times Tables")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                    .sheet(isPresented: $settingsView) {
                        Settings(chosenNumber: $chosenNumber, questions: $questions, settingsView: $settingsView)
                    }
                
                if !endGame {
                    VStack {
                        Text("What is \(chosenNumber) * \(number)?")
                            .customFontSize()
                        Text("Question: \(questionNumber)/\(questions)")
                            .customFontSize()
                        Text("Score: \(score)/\(questions)")
                            .customFontSize()
                            .padding(.bottom, 10)
                        
                        
                        TextField("Answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(CustomRoundedBorderTextFieldStyle())
                            .padding(.bottom, 5)
                        
                        
                        Button("Submit") {
                            angle += 360
                            controlFlow(userAnswer)
                        }
                        .rotationEffect(.degrees(angle))
                        .animation(animation)
                        .customFontSize()
                        .foregroundColor(.black)
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            Button("End Game"){
                                earlyEnd.toggle()
                                endGame.toggle()
                            }
                            .foregroundColor(color)
                        }
                    }
                } else {
                    Text(earlyEnd ? "The game has abruptly ended. Score of exit: \(score)/\(questionNumber - 1)" : "The game has ended. Final score: \(score)/\(questions)")
                        .font(.system(size: 20))
                        .padding()
                    HStack {
                        Button("Restart"){
                            restartGame()
                        }
                        .customButtonStyle(color: color)
                        .padding(.trailing, 97)
                        Button("Settings"){
                            settingsView.toggle()
                        }
                        .customButtonStyle(color: color)
                    }
                    
                }
                
                Spacer()
            }
        }
        .padding()
        .background(endGame ? .white : color, ignoresSafeAreaEdges: .all)
    }
    
    func multiply(chosenNumber: Int, number: Int) -> Int {
        chosenNumber * number
    }
    
    func controlFlow(_ userAnswer: String) {
        if let userIntAnswer = Int(userAnswer) {
            answer = multiply(chosenNumber: chosenNumber, number: number)
            
            if userIntAnswer == answer {
                score += 1
            } else {
            }
            
            if questionNumber == questions {
                endGame.toggle()
            } else {
                questionNumber += 1
                setDynamicValues()
                nextQuestion()
            }
        }
    }
    
    func setDynamicValues() {
        if let selectedColor = colors.randomElement() {
            color = selectedColor
        } else {
            color = .white
        }
        if let selectedAnimation = animations.randomElement() {
            animation = selectedAnimation
        } else {
            animation = .bouncy
        }
    }
    
    func nextQuestion() {
        number = Int.random(in: 2..<12)
        userAnswer = ""
    }
    func restartGame() {
        if earlyEnd {
            earlyEnd.toggle()
        }
        questionNumber = 1
        endGame = false
        score = 0
        nextQuestion()
    }
}

#Preview {
    ContentView()
}
