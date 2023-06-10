//
//  ContentView.swift
//  BetterRest
//
//  Created by Dwiki Dwiki on 02/06/23.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    private var calculatedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
        
            return sleepTime.formatted(date: .omitted, time: .shortened)
           
        } catch {
            alertTitle = "Error"
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    
   static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header:Text("When do you want to wake up ?")){
                 
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header:  Text("Desired amount of sleep")){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                
                Section(header: Text("Daily coffee intake")){
                    Picker("coffee intake", selection: $coffeeAmount) {
                        ForEach(1...20, id:\.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Text(calculatedTime)
                }
               
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") {}
            } message: {
                Text(alertMessage)
                    .font(.headline)
            }
    
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
