//
//  MiniGamesView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct MiniGamesView: View {
    @ObservedObject var gameData: GameData
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { g in
            VStack(alignment: .center, spacing: 20){
                Spacer()
                NavigationLink {
                    GuessNumberView(gameData: gameData, gameViewModel: gameViewModel)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width , height: g.size.height * 0.15)
                        HStack{
                            Text("GUESS THE NUMBER")
                                .foregroundStyle(.white)
                                .font(.title2.weight(.bold)) // Uses iOS's default title size + heavy weight
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.15)
                        
                    }
                }
                NavigationLink {
                    MemoryGameView(gameData: gameData, gameViewModel: gameViewModel)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width , height: g.size.height * 0.15)
                        HStack{
                            Text("CARD MATCH")
                                .foregroundStyle(.white)
                                .font(.title2.weight(.bold)) // Uses iOS's default title size + heavy weight
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.15)
                        
                    }
                }
                NavigationLink {
                    MemorySequnceGameView(gameData: gameData, gameViewModel: gameViewModel)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width , height: g.size.height * 0.15)
                        HStack{
                            Text("SIMON SAYS")
                                .foregroundStyle(.white)
                                .font(.title2.weight(.bold)) // Uses iOS's default title size + heavy weight
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.15)
                        
                    }
                }
                NavigationLink {
                    MazeView(gameData: gameData, gameViewModel: gameViewModel)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width , height: g.size.height * 0.15)
                        HStack{
                            Text("MAZE CHALLENGE")
                                .foregroundStyle(.white)
                                .font(.title2.weight(.bold)) // Uses iOS's default title size + heavy weight
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .frame(width: g.size.width * 0.8, height: g.size.height * 0.15)
                        
                    }
                }
                
                Spacer()
            }

        }
    }
}

//#Preview {
//    MiniGamesView()
//}
