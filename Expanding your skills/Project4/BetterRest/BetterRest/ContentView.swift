//
//  ContentView.swift
//  BetterRest
//
//  Created by user on 5/25/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State public var message = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    

    var body: some View {
        NavigationStack {
            Form {
                // I already know Section version is this Section(header: Text("When do you want to wake up?").font(.headline))
                // But it looks ugly and Id rather have a Vstack plus Paul said I can choose either or
                VStack(alignment: .leading, spacing: 0){

                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Picker("Coffee Amount", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) { cups in
                            Text("\(cups) cup\(cups == 1 ? "" : "s")")
                        }
                    }
                    .labelsHidden()
                }
            }
            .onAppear {
                message = calculateBedtime()
            }
            // for some weird reason swiftUI is not changing the data in my Text view
            // So I found this way so it can track changes in each property
            .onChange(of: wakeUp){
                message = calculateBedtime()
            }
            .onChange(of: sleepAmount){
                message = calculateBedtime()
            }
            .onChange(of: coffeeAmount){
                message = calculateBedtime()
            }
            Spacer()
            Text(message)
            Spacer()
            .navigationTitle("BetterRest")
        }
    }

    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            message = "Your ideal bedtime is: \(sleepTime.formatted(date: .omitted, time: .shortened))"
        } catch {
            message = "Error: Sorry, there was a problem calculating your bedtime."
        }
        return message
    }
}

#Preview {
    ContentView()
}
