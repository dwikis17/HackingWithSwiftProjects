//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Dwiki Dwiki on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShouldWin = Bool.random()
    
    
    @State private var score = 0
    
    @State private var computersMove = Move.allCases.randomElement()
    
    @State var gameCount = 0
    
    enum Move: String, CaseIterable {
        case rock = "Rock", paper = "Paper", scissor = "Scissor"
    }
    
    func makeMove (with move: Move) {
            if isShouldWin {
                if (computersMove == Move.rock && move == Move.paper ||
                    computersMove == Move.paper && move == Move.scissor ||
                    computersMove == Move.scissor && move == Move.rock
                ) {
                    print("msk score")
                    score += 10
                }
                
            } else {
                if (computersMove == Move.rock && move == Move.scissor ||
                    computersMove == Move.paper && move == Move.rock ||
                    computersMove == Move.scissor && move == Move.paper
                ) {
                    score += 10
                }
            }
            
            computersMove = Move.allCases.randomElement()
            isShouldWin.toggle()
            gameCount+=1
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green:0.2, blue:0.31), location: 0.3),
                .init(color: Color(red:0.1, green:0.15, blue:0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissor")
                    .font(.largeTitle)
                    
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Player score : \(score)")
                        .font(.subheadline)
                    Text("Computer's next move: \(computersMove!.rawValue ) ")
                    if isShouldWin {
                        Text("You should Win !")
                            .foregroundColor(.green)
                    } else {
                        Text("You should lose !")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical)
                
                Spacer()
                Spacer()
                
                if gameCount < 10 {
                    Text("Choose your move")
                    HStack {
                        ForEach(Move.allCases, id: \.self) { move in
                            Button(action: {
                                makeMove(with: move)
                            }) {
                                Text(move.rawValue)
                            }
                            .frame(width:100, height: 100)
                            .background(.green)
                            .cornerRadius(20)
                        }
                    }
                } else {
                    VStack {
                        Text("Game over !")
                        Text("Your final score is : \(score)")
                        Button {
                            gameCount = 0
                        } label: {
                            Text("Restart")
                        }
                        .background(.primary)
                        .foregroundColor(.black)

                    }
                }
               

                Spacer()
                Spacer()
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
