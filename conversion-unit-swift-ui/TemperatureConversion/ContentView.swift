//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Dwiki on 26/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperatureValue = 0.0
    @State private var selectedUnit = "Kelvin"
    @FocusState private var isTemperatureValueFocused:Bool
    
    var convertedValue : Double{
        
        if(selectedUnit == "Kelvin"){
            return temperatureValue + 273.15
        } else if (selectedUnit == "Reamur"){
            return temperatureValue * 4/5
        } else {
            return (temperatureValue * 9/5) + 32
        }
    }
    
    let temperatureUnits = ["Kelvin", "Reamur", "Fahrenheit"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Value:" , value: $temperatureValue, format: .number )
                        .keyboardType(.decimalPad)
                        .focused($isTemperatureValueFocused)
                } header: {
                    Text("Input value in celsius")
                }
                
                Section{
                    Picker("Select Unit", selection: $selectedUnit){
                        ForEach(temperatureUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select unit")
                }
                
                Section{
                    Text(convertedValue, format:.number)
                } header: {
                    Text("Value in \(selectedUnit)")
                }
            }
            .navigationTitle("Conversion Unit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        isTemperatureValueFocused = false
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
