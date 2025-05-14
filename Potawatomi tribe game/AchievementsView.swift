//
//  AchievementsView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 13.05.2025.
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameViewModel: GameViewModel

    @ObservedObject var gameData: GameData

    var body: some View {
        GeometryReader { g in
            ZStack {
                Image("\(gameViewModel.backgroundImage)")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                        
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            Text("ACHIEVEMENTS")
                                .foregroundStyle(.white)
                                .font(.title.weight(.bold)) // Uses iOS's default title size + heavy weight
                            Spacer()
                            
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundStyle(.clear)
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.078)
                    }
                    .padding(.vertical)
                    
                    VStack{
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.15)
                            HStack{
                                Image("image-2")
                                    .resizable()
                                    .scaledToFill()
                                    .saturation(gameViewModel.completedFirstLevel ? 1.0 : 0.0)
                                    .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    .clipped()
                                    .padding(.trailing, 10)
                                
                                VStack(alignment:.leading){
                                    Text("SHEPHERD")
                                        .foregroundStyle(.white)
                                        .font(.headline.weight(.bold)) // Uses iOS's default title size + heavy weight
                                    Text("Complete the first level")
                                        .foregroundStyle(.white)
                                        .font(.callout)
                                    
                                    if gameViewModel.completedFirstLevel && gameViewModel.hideCompletedFirstLevel == false {
                                        Button {
                                            gameData.addCoins(10)
                                            gameViewModel.hideCompletedFirstLevel = true
                                        } label: {
                                            Text("CLAIM 10")
                                                .foregroundStyle(.black)
                                                .font(.caption.weight(.bold)) // Uses iOS's default title size + heavy weight
                                                .padding(7)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                }

                                        }

                                    }
                                }
                                Spacer()
                                
                                
                            }
                            .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                            
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.15)
                            HStack{
                                Image("image-3")
                                    .resizable()
                                    .scaledToFill()
                                    .saturation(gameViewModel.completed5Levels ? 1.0 : 0.0)

                                    .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    .clipped()
                                
                                VStack(alignment:.leading){
                                    Text("RIDER")
                                        .foregroundStyle(.white)
                                        .font(.headline.weight(.bold)) // Uses iOS's default title size + heavy weight
                                    Text("Complete 5 level")
                                        .foregroundStyle(.white)
                                        .font(.callout)
                                    if gameViewModel.completed5Levels && gameViewModel.hideCompleted5Levels == false {
                                        Button {
                                            gameData.addCoins(10)
                                            gameViewModel.hideCompleted5Levels = true
                                        } label: {
                                            Text("CLAIM 10")
                                                .foregroundStyle(.black)
                                                .font(.caption.weight(.bold)) // Uses iOS's default title size + heavy weight
                                                .padding(7)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                }

                                        }

                                    }

                                }
                                Spacer()
                                
                                
                            }
                            .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                            
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.15)
                            HStack{
                                Image("image-4")
                                    .resizable()
                                    .scaledToFill()
                                    .saturation(gameViewModel.completed7Levels ? 1.0 : 0.0)

                                    .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    .clipped()
                                
                                VStack(alignment:.leading){
                                    Text("COWBOY")
                                        .foregroundStyle(.white)
                                                                                .font(.headline.weight(.bold)) // Uses iOS's default title size + heavy weight

                                    Text("Complete 7 level")
                                        .foregroundStyle(.white)
                                        .font(.callout)
                                    if gameViewModel.completed7Levels && gameViewModel.hideCompleted7Levels == false {
                                        Button {
                                            gameData.addCoins(10)
                                            gameViewModel.hideCompleted7Levels = true
                                        } label: {
                                            Text("CLAIM 10")
                                                .foregroundStyle(.black)
                                        .font(.caption.weight(.bold)) // Uses iOS's default title size + heavy weight
                                                .padding(7)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                }

                                        }

                                    }

                                }
                                Spacer()
                                
                                
                            }
                            .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                            
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.15)
                            HStack{
                                Image("image-5")
                                    .resizable()
                                    .scaledToFill()
                                    .saturation(gameViewModel.accumulated1000hourseshoes ? 1.0 : 0.0)

                                    .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    .clipped()
                                
                                VStack(alignment:.leading){
                                    Text("FARMER")
                                        .foregroundStyle(.white)
                                                                                .font(.headline.weight(.bold)) // Uses iOS's default title size + heavy weight

                                    Text("Accumulate 1000 hourseshoes")
                                        .foregroundStyle(.white)
                                        .font(.callout)
                                    if gameViewModel.accumulated1000hourseshoes && gameViewModel.hideAccumulated == false {
                                        Button {
                                            gameData.addCoins(10)
                                            gameViewModel.hideAccumulated = true
                                        } label: {
                                            Text("CLAIM 10")
                                                .foregroundStyle(.black)
                                        .font(.caption.weight(.bold)) // Uses iOS's default title size + heavy weight
                                                .padding(7)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                }

                                        }

                                    }

                                }
                                Spacer()
                                
                                
                            }
                            .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                            
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.15)
                            HStack{
                                Image("image-6")
                                    .resizable()
                                    .scaledToFill()
                                    .saturation(gameViewModel.completedAllLevels ? 1.0 : 0.0)

                                    .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    .clipped()
                                
                                VStack(alignment:.leading){
                                    Text("SHERIFF")
                                        .foregroundStyle(.white)
                                                                                .font(.headline.weight(.bold)) // Uses iOS's default title size + heavy weight

                                    Text("Complete all levels")
                                        .foregroundStyle(.white)
                                        .font(.callout)
                                    if gameViewModel.completedAllLevels && gameViewModel.hideCompletedAllLevels == false {
                                        Button {
                                            gameData.addCoins(10)
                                            gameViewModel.hideCompletedAllLevels = true
                                        } label: {
                                            Text("CLAIM 10")
                                                .foregroundStyle(.black)
                                        .font(.caption.weight(.bold)) // Uses iOS's default title size + heavy weight
                                                .padding(7)
                                                .background {
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                }

                                        }

                                    }

                                }
                                Spacer()
                                
                                
                            }
                            .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                            
                        }

                    }
                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.8)

                }
                .frame(width: g.size.width * 0.9, height: g.size.height * 0.9)

            }
        }
        .navigationBarBackButtonHidden()

    }
}

