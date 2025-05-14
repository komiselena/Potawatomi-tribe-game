//
//  GuessNumberView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct GuessNumberView: View {
    @ObservedObject var gameData: GameData
    @Environment(\.dismiss) private var dismiss
    @StateObject private var game = GuessTheNumberGame()
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                Image("\(gameViewModel.backgroundImage)")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Шапка
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                        
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            Text("GUESS THE NUMBER")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .font(.title)
                            Spacer()
                            
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundStyle(.clear)
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.08)
                    }
                    
                    Spacer()
                    
                    // Игровое поле
                    VStack(spacing: 10) {
                        // Три красных квадрата для числа
                        HStack(spacing: 10) {
                            ForEach(0..<3, id: \.self) { index in
                                ZStack {
                                    Rectangle()
                                        .fill(Color.red)
                                        .frame(width: g.size.width * 0.25, height: g.size.width * 0.25)
                                    
                                    if index < game.guess.count {
                                        Text(String(game.guess[game.guess.index(game.guess.startIndex, offsetBy: index)]))
                                            .font(.system(size: 40, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.width * 0.25)

                        // Подсказка
                        if !game.hint.isEmpty {
                            Text(game.hint)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .animation(.easeInOut, value: game.hint)
                        }
//                            .frame(width: g.size.width * 0.9, height: g.size.width * 0.28)

                        
                        Spacer()
                        
                        // Цифровая клавиатура
                        VStack(spacing: 10) {
                            ForEach(0..<3, id: \.self) { row in
                                HStack(spacing: 10) {
                                    ForEach(1..<4, id: \.self) { col in
                                        let number = row * 3 + col
                                        Button {
                                            if game.guess.count < 3 && !game.isWon {
                                                game.guess += "\(number)"
                                                checkIfComplete()
                                            }
                                        } label: {
                                            Text("\(number)")
                                                .font(.title)
                                                .frame(width: g.size.width * 0.25, height: g.size.width * 0.17)
                                                .background(Color.white)
                                                .foregroundColor(.black)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            
                            // Последний ряд (только 0 по центру)
                            HStack(spacing: 10) {
                                Spacer()
                                    .frame(width: g.size.width * 0.25, height: g.size.width * 0.17)

                                Button {
                                    if game.guess.count < 3 && !game.isWon {
                                        game.guess += "0"
                                        checkIfComplete()
                                    }
                                } label: {
                                    Text("0")
                                        .font(.title)
                                        .frame(width: g.size.width * 0.25, height: g.size.width * 0.17)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                                
                                Button {
                                    if !game.guess.isEmpty && !game.isWon {
                                        game.guess.removeLast()
                                    }
                                } label: {
                                    Image(systemName: "delete.left")
                                        .font(.title)
                                        .frame(width: g.size.width * 0.25, height: g.size.width * 0.17)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.6)

                    }
//                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.2)
                    
                    Spacer()
                }
                .frame(width: g.size.width * 0.9, height: g.size.height * 0.9)


            }
            .frame(width: g.size.width , height: g.size.height )

            .overlay {
                if game.isWon {
                    ZStack{
                        Color.black
                            .opacity(0.3)
                            .ignoresSafeArea()
                        
                        Image("Button-4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.4)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
            }
            .onChange(of: game.isWon) { newValue in
                if game.isWon == true{
                    gameData.addCoins(20)
                }
            }


        }
        .navigationBarBackButtonHidden()
    }
    
    private func checkIfComplete() {
        if game.guess.count == 3 {
            game.checkGuess()
        }
    }
}
