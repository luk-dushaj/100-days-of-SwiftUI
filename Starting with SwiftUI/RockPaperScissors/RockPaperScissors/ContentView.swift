//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by user on 5/22/24.
//

// We only track who wins round and at the end of the game only output users score
// Eventually throw a guard in somewhere in the code to reset the round if both moves type matches
/*
 Have 3 .alert modifiers
 1. Output who won the round
 2. Output a tie and restarting the round
 3. Output the end and the overall score with a restart button
 */

import SwiftUI

enum Option: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
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
//    private var winner: String {
//        whoWins(move: playerMove, compareTo: computerMove) ? "won" : "lost"
//    }
    private var options = Option.allCases
        private var icons = [
            "Rock": "🪨",
            "Paper": "📄",
            "Scissors": "✂️"
        ]
        
        @State private var index: Int = Int.random(in: 0..<Option.allCases.count)
        
        private var computerMove: Option {
            options[index]
        }
    
    // This func takes in 2 option and returns a boolean to see if it wins
    func whoWins(move: Option, compareTo move2: Option) -> Bool {
        switch move {
        case .rock:
            move2 != .paper ? true : false
        case .paper:
            move2 != .scissors ? true : false
        case .scissors:
            move2 != .rock ? true : false
        }
    }
    
    // If true .alert will tell the user you both have selected \(playerMove) restart the round
    func checkMoves(_ playerMove: Option) -> Bool {
        guard playerMove != computerMove else {
            return false
        }
        return true
    }
    
    func buttonTapped(_ playerMove: Option) {
        if questionNumber == 10 {
            endGame = true
        }
        isTie = checkMoves(playerMove)
        if isTie {
            // generate new computer move
            self.index = Int.random(in: 0..<options.count)
        }
        questionNumber += 1
        if whoWins(move: playerMove, compareTo: computerMove) {
            scoreTitle = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            message = "No \(playerMove.rawValue) does not beat \(computerMove.rawValue)!"
            guard score != 0 else {
                return
            }
            score -= 1
        }
        
    }
    
    var body: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                Button {
                    buttonTapped(option)
                } label: {
                    if let iconName = icons[option.rawValue] {
                        Text(iconName)
                    } else {
                        // Handle the case where the value is nil
                        Text("Default Icon")
                    }
                }
                
            }
        }
        .padding()
        .alert("Whoops! Looks like a draw. Try again.", isPresented: $isTie) {
            Button("Continue", action: {
                isTie = false
            })
            .alert("Game is over", isPresented: $endGame){
                Button("Restart", action: {
                    endGame = false
                    score = 0
                    questionNumber = 1
                })
            } message: {
                Text("Overall score: \(score)/10")
            }
        }
    }
}

#Preview {
    ContentView()
}
