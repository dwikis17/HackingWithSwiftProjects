//
//  ContentView.swift
//  WeSplit
//
//  Created by Dwiki on 05/02/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson : Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var customFormatter :FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var grandTotal : Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Amount :" ,value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<10){
                            Text("\($0) people")
                        }
                    }
                }
                	
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101, id: \.self){
                            Text($0, format:.percent)
                        }
                    }
    
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section {
                    Text(grandTotal, format:customFormatter)
                } header: {
                    Text("Grand total")
                }
                
                Section {
                    Text(totalPerPerson, format: customFormatter)
                } header: {
                    Text("Amount per persons")
                }
                
            
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
