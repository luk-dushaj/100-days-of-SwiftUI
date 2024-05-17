//
//  ContentView.swift
//  LengthConverter
//
//  Created by user on 5/14/24.

import SwiftUI

struct ContentView: View {
    
    enum Unit: CaseIterable {
        case meters, kilometers, feet, yard, miles
        
        var id: Self { self }
    }
    
    @State private var input: Double = 0.0
    @State private var inputType: Unit = .feet
    @State private var outputType: Unit = .feet
    
    var output: Double {
        let feet = getFeet(input, type: inputType)
        return convert(feet, type: outputType)
    }
    
    func getFeet(_ input: Double, type: Unit) -> Double {
        switch type {
        case.meters:
            return input * 3.281
        case.miles:
            return input * 5280
        case.yard:
            return input * 3
        case.kilometers:
            return input * 3281
        default:
            return input
        }
    }
    
    func convert(_ input: Double, type: Unit) -> Double {
        switch type {
        case.meters:
            return input / 3.281
        case.miles:
            return input / 5280
        case.yard:
            return input / 3
        case.kilometers:
            return input / 3281
        default:
            return input
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Input number", value: $input, format: .number)
                        .keyboardType(.numberPad)
                    Picker("Length", selection: $inputType) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text("\(unit)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Unit to convert to")){
                    Picker("Length", selection: $outputType) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text("\(unit)")
                        }
                    }
                }
                
                Section(header: Text("Output")){
                    Text("The output is \(output)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
