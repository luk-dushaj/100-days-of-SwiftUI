//
//  ContentView.swift
//  WeSplit
//
//  Created by user on 5/11/24.
//

/*
 Directions:
 
 In this project we’re going to be building a check-splitting app that you might use after eating at a restaurant – you enter the cost of your food, select how much of a tip you want to leave, and how many people you’re with, and it will tell you how much each person needs to pay.
 */

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal : Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField( "Amount", value: $checkAmount, format: .currency (code:
                        Locale.current.currency?.identifier ?? "USD") )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0..<101) {
                            Text("\($0) people")
                        }
                    }
                    // To open a new view full of the list
                    .pickerStyle(.navigationLink)
                }
                
                Section ("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section(header: Text("Amount per person")){
                    Text(totalPerPerson, format: .currency (code:
                        Locale.current.currency?.identifier ?? "USD" ) )
                }
                
                Section(header : Text("Total amount of check")){
                    Text(grandTotal, format: .currency (code:
                                                                Locale.current.currency?.identifier ?? "USD" ) )
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
