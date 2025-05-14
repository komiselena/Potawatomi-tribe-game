//
//  MainMenuView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI

struct MainMenuView: View {
    @State private var showMiniGamesModal: Bool = false
    @ObservedObject var gameData = GameData()
    @ObservedObject var gameViewModel = GameViewModel()

    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack {
                GeometryReader{ g in
                    ZStack{
                        Image("\(gameViewModel.backgroundImage)")
                            .resizable()
                            .ignoresSafeArea()
                        VStack{
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .padding(.vertical)
                            ZStack{
                                Capsule()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.25, height: g.size.height * 0.06)
                                HStack(spacing: g.size.width * 0.03){
                                    Image("1a05d90a-45cf-46bb-b7dc-597f421bcc95-Photoroom 1")
                                        .resizable()
                                        .frame(width: g.size.height * 0.07, height: g.size.height * 0.07)
                                    //                                Spacer()
                                    Text("\(gameData.coins)")
                                        .foregroundStyle(.white)
                                        .font(.title2)
                                    Spacer()
                                }
                                .frame(width: g.size.width * 0.29, height: g.size.height * 0.1)
                                
                            }
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                Button {
                                    showMiniGamesModal = true
                                } label: {
                                    Image("Button")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                    
                                }
                                
                            }
                            NavigationLink {
                                LevelView(gameViewModel: gameViewModel)
                                
                            } label: {
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(.red)
                                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                                    Text("PLAY GAME")
                                        .foregroundStyle(.white)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical)
                            
                            HStack{
                                NavigationLink {
                                    ShopView(gameViewModel: gameViewModel, gameData: gameData)
                                } label: {
                                    ZStack{
                                        Rectangle()
                                            .foregroundStyle(.white)
                                        Text("SHOP")
                                            .foregroundStyle(.black)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                    }
                                }
                                NavigationLink {
                                    AchievementsView(gameViewModel: gameViewModel, gameData: gameData)
                                    //                            GameView()
                                } label: {
                                    ZStack{
                                        Rectangle()
                                            .foregroundStyle(.white)
                                        Text("ACHIEVEMENTS")
                                            .foregroundStyle(.black)
                                            .fontWeight(.bold)
                                            .font(.title3)
                                    }
                                }
                            }
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.08)
                            
                            NavigationLink {
                                SettingsView(gameViewModel: gameViewModel)
                                //                            GameView()
                            } label: {
                                ZStack{
                                    Rectangle()
                                        .foregroundStyle(.white)
                                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.08)
                                    Text("SETTINGS")
                                        .foregroundStyle(.black)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                }
                            }
                            
                            
                        }
                        .padding()
                        .frame(width: g.size.width , height: g.size.height)
                        .overlay{
                            if showMiniGamesModal{
                                ZStack{
                                    Color.black.opacity(0.6)
                                        .ignoresSafeArea()
                                    VStack{
                                        MiniGamesView(gameData: gameData, gameViewModel: gameViewModel)
                                            .padding()
                                        HStack{
                                            Spacer()
                                            Button {
                                                showMiniGamesModal = false
                                                
                                            } label: {
                                                Image(systemName: "xmark.circle")
                                                    .font(.title)
                                                    .foregroundStyle(.white.opacity(0.8))
                                                
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    .frame(height: g.size.height * 0.7)
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}


