//
//  ContentView.swift
//  WorldScrambleHackingWithSwift
//
//  Created by Dwiki Dwiki on 05/06/23.
//

import SwiftUI

struct ContentView: View {
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "You cant spell")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "not even real", message: "not even real word")
            return
        }
        
        guard answer.count >= 3 else {
            wordError(title: "short", message: "answer too short")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "duplicated", message: "cant be root word")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        score += answer.count
        newWord = ""
    }
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
        
    @State private var score = 0
    
    var body: some View {
        NavigationView {
              List {
                  Section {
                      TextField("Enter your word", text: $newWord)
                          .textInputAutocapitalization(.never)
                          .onSubmit(addNewWord)
                  }
                  
                  Section {
                      Text("Your score is : \(score)")
                  }
                  
                  Section {
                      ForEach(usedWords, id: \.self) { word in
                          HStack {
                              Image(systemName: "\(word.count).circle")
                              Text(word)
                          }
                      }
                  }
                  
                 
              }
              .navigationTitle(rootWord)
              .toolbar {
                  Button {
                      startGame()
                  } label: {
                      Text("New Game")
                  }

              }
              .listStyle(.inset)
          
              .onAppear(perform: startGame)
              .alert(errorTitle, isPresented: $showingError) {
                  Button("OK", role: .cancel) {}
              } message: {
                  Text(errorMessage)
              }
          }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkwood"
                return
            }
        }
        
        fatalError("Could not load start.txt from the bundle")
    }

    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var temporaryWord = rootWord
        
        for letter in word {
            if let pos = temporaryWord.firstIndex(of: letter){
                temporaryWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
