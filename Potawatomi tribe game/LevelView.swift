//
//  LevelView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI
import SpriteKit

struct LevelView: View {
    @Environment(\.dismiss) var dismiss
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
    private let numberOfLevels = 10
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        NavigationView {
            GeometryReader { g in
                ZStack {
                    Image("\(gameViewModel.backgroundImage)")
                        .resizable()
                        .ignoresSafeArea()
                    
                    VStack {
                        // Header
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
                                Text("LEVELS")
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Spacer()
                                
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundStyle(.clear)
                            }
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.078)
                        }
                        .padding(.vertical)
                        
                        // Levels grid
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(1...numberOfLevels, id: \.self) { level in
                                NavigationLink {
                                    SpriteKitContainer()
                                        .edgesIgnoringSafeArea(.all)
                                        .environmentObject(gameViewModel)
                                        .navigationBarBackButtonHidden()
                                        .overlay(
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
                                                    Text("LEVEL \(level)")
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.bold)
                                                        .font(.title)
                                                    Spacer()
                                                    
                                                    Image(systemName: "arrow.left")
                                                        .font(.title2)
                                                        .foregroundStyle(.clear)
                                                }
                                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.078)
                                            }
                                            .padding(.vertical)

                                            
                                            , alignment: .top)
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundStyle(.white)
                                            .frame(width: g.size.width * 0.25, height: g.size.height * 0.09)
                                        Text("\(level)")
                                            .foregroundStyle(.black)
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


