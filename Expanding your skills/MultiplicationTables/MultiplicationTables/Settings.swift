////
////  Settings.swift
////  MultiplicationTables
////
////  Created by user on 6/18/24.
////
//
//import SwiftUI
//
//struct Settings: View {
//    
//    let chosenNumber: Int
//    let questionOptions: Int
//    
//    
//    var body: some View {
//        
//        
//        Section("What table do you want to practice?"){
//                        Stepper("\(chosenNumber) tables", value: $chosenNumber, in: 2...12, step: 1)
//                    }
//                    
//                    Section("How much questions do you want?"){
//                        Picker("Questions", selection: $questions){
//                            ForEach(questionOptions, id: \.self) { questionIndex in
//                                Text("\(questionIndex)")
//                            }
//                        }
//                        
//                        .pickerStyle(.segmented)
//                    }
//    }
//}
//
//#Preview {
//    Settings(chosenNumber: <#T##Int#>, questionOptions: <#T##Int#>)
//}
