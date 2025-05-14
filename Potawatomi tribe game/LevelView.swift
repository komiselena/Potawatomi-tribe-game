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
    @State private var selectedLevel: Int? = nil
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack {
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
                                        Image(systemName: "chevron.left")
                                            .font(.title2)
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.leading)
                                    
                                    Spacer()
                                    Text("LEVELS")
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
                            
                            // Levels grid
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(1...numberOfLevels, id: \.self) { level in
                                    Button {
                                        if level <= gameViewModel.unlockedLevels {
                                            selectedLevel = level
                                            gameViewModel.currentLevel = level
                                        }
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .foregroundStyle(level <= gameViewModel.unlockedLevels ? .white : .gray.opacity(0.7))
                                                .frame(width: g.size.width * 0.28, height: g.size.height * 0.1)
                                            Text("\(level)")
                                                .foregroundStyle(level <= gameViewModel.unlockedLevels ? .black : .gray)
                                                .font(.title)
                                                .fontWeight(.bold)
                                        }
                                    }
                                    .disabled(level > gameViewModel.unlockedLevels)
                                }
                            }
                            .padding()
                            
                            Spacer()

                        }
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .fullScreenCover(item: $selectedLevel) { level in
                SpriteKitContainer()
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(gameViewModel)
            }
        }
    }
}


extension Int: Identifiable {
    public var id: Int { self }
}
