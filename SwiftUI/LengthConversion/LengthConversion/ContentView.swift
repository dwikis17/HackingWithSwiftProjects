//
//  ContentView.swift
//  LengthConversion
//
//  Created by Dwiki Dwiki on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputNumber: Double = 0
    @State var selectedInitialUnit = "Metre"
    @State var selectedConvertedUnit = "Metre"
    var convertedValue : Double {
        if selectedInitialUnit == selectedConvertedUnit {
            return inputNumber
        }
        
        if selectedInitialUnit == "Metre" {
            if selectedConvertedUnit == "Kilometre" {
                return inputNumber / 1000
            } else if selectedConvertedUnit == "Yard" {
                return inputNumber * 1.09361
            } else {
                return inputNumber * 0.000621371
            }
        } else if selectedInitialUnit == "Kilometre" {
            if selectedConvertedUnit == "Metre" {
                return inputNumber *  1000
            } else if selectedConvertedUnit == "Yard" {
                return inputNumber * 1093.61
            } else {
                return inputNumber * 0.621371
            }
        } else if selectedInitialUnit == "Yard" {
            if selectedConvertedUnit == "Metre" {
                return inputNumber * 0.9144
            } else if selectedConvertedUnit == "Kilometre" {
                return inputNumber * 0.0009144
            } else {
                return inputNumber * 0.000568182
            }
        } else {
            if selectedConvertedUnit == "Metre" {
                return inputNumber * 1609.34
            } else if selectedConvertedUnit == "Kilometre" {
                return inputNumber * 1.60934
            } else {
                return inputNumber * 1760
            }
        }
    }
    @FocusState private var isFocused:Bool
    
    let lengthUnits = ["Metre", "Kilometre", "Yard", "Miles"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("0", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Select unit", selection: $selectedInitialUnit) {
                        ForEach(lengthUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input your number and unit")
                }
                
                Section {
                    Picker("Select unit", selection: $selectedConvertedUnit) {
                        ForEach(lengthUnits, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(convertedValue, format:.number)
                } header: {
                    Text("Result in \(selectedConvertedUnit) ")
                }
            }
            .navigationTitle("Conversion Unit")
        }
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
