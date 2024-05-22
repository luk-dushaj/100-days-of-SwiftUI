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

enum Option: CaseIterable {
    case rock, paper, scissors
}

struct ContentView: View {
    @State private var playerMove = Option.rock
    @State private var questionNumber = 1
    @State private var score = 0
    @State private var sameMove = false
    private var computerMove: Option {
            let allCases = Option.allCases
            let index = Int.random(in: 0..<allCases.count)
            return allCases[index]
    }
    private var winner: String {
        whoWins(move: playerMove, compareTo: computerMove) ? "won" : "lost"
    }
    private var movesCount = Option.allCases.count
    
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
    func checkMoves() -> Bool {
        guard playerMove != computerMove else {
            return true
        }
        return false
    }
    
    func buttonTapped() {
        
    }
    
    var body: some View {
        VStack {
            ForEach(0..<movesCount){ move in
                Button {
                    buttonTapped(move)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
