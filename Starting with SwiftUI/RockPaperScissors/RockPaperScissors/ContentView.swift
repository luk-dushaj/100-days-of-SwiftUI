//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by user on 5/22/24.
//

import SwiftUI

enum Option: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct ButtonStyle: View {
    let iconName: String
    
    var icons = [
        "Rock": "🪨",
        "Paper": "📄",
        "Scissors": "✂️"
    ]
    var body: some View {
        
        if let icon = icons[iconName] {
            Text(icon)
                .font(.system(size: 100))
                .frame(maxWidth: 200, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 10)
                .background(Color(red: 0.1, green: 0.7, blue: 0.99))
                .clipShape(.rect(cornerRadius: 50))
        } else {
            Text("Default Icon")
        }
    }
}

struct TextStyle: View {
    let string: String
    var body: some View {
        Text(string)
            .foregroundColor(.secondary)
            .fontWeight(.heavy)
    }
}

struct ContentView: View {
    //@State private var playerMove = Option.rock
    @State private var questionNumber = 1
    @State private var endGame = false
    @State private var score = 0
    @State private var sameMove = false
    @State private var isTie = false
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var showingScore = false
    
    private var options = Option.allCases
    
    @State private var index: Int = Int.random(in: 0..<Option.allCases.count)
    
    private var computerMove: Option {
        options[index]
    }
    
    var body: some View {
        ZStack {
            Color.primary
            VStack {
                Spacer()
                TextStyle(string: "Rock, Paper, Scissors")
                    .font(.largeTitle.weight(.semibold))
                
                Spacer()
                Spacer()
                ForEach(options, id: \.self) { option in
                    Button {
                        buttonTapped(option)
                    } label: {
                        // need if let because option.rawValue can potentially be nil
                        ButtonStyle(iconName: option.rawValue)
                    }
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
            Spacer()
            VStack {
                Spacer()
                HStack(spacing: 150) {
                    TextStyle(string: "Round: \(questionNumber)/10")
                        .padding(.bottom, 35)
                    TextStyle(string: "Score: \(score)/10")
                        .padding(.bottom, 35)
                }
            }
        }
        .ignoresSafeArea()
        
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: {
                showingScore = false
            })
        } message: {
            Text(message)
        }
        .alert("Whoops! Looks like a draw. Try again.", isPresented: $isTie) {
            Button("Continue", action: {
                isTie = false
            })
        }
        .alert("Game Over", isPresented: $endGame) {
            Button("Restart", action: {
                endGame = false
                score = 0
                questionNumber = 1
                showingScore = false
            })
        } message: {
            Text("Overall score: \(score)/10")
        }
    }
    
    // This func takes in 2 option and returns a boolean to see if it wins
    func whoWins(move: Option, compareTo move2: Option) -> Bool {
        switch move {
        case .rock:
            return move2 == .scissors
        case .paper:
            return move2 == .rock
        case .scissors:
            return move2 == .paper
        }
    }
    
    // If true .alert will tell the user you both have selected \(playerMove) restart the round
    func checkMoves(_ playerMove: Option) -> Bool {
        if playerMove.rawValue == computerMove.rawValue {
            return true
        } else {
            return false
        }
    }
    
    func buttonTapped(_ playerMove: Option) {
        isTie = checkMoves(playerMove)
        if isTie {
            // generate new computer move
            self.index = Int.random(in: 0..<options.count)
            return
        }
        if questionNumber == 10 {
            endGame = true
        } else {
            questionNumber += 1
        }
        if whoWins(move: playerMove, compareTo: computerMove) {
            scoreTitle = "Correct"
            score += 1
            message = "Your score is \(score)"
            showingScore = true
            self.index = Int.random(in: 0..<options.count)
        } else {
            scoreTitle = "Wrong"
            message = "No \(playerMove.rawValue) does not beat \(computerMove.rawValue)!"
            if score != 0 {
                score -= 1
            }
        }
        showingScore = true
        self.index = Int.random(in: 0..<options.count)
        
    }
    
}

#Preview {
    ContentView()
}
