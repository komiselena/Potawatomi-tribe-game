//
//  MazeView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI
import SpriteKit

struct MazeView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var scene = MazeGameScene(size: CGSize(width: 196, height: 196))
    @ObservedObject var gameData: GameData
    @State private var timeLeft = 90
    @State private var timer: Timer?
    @State private var showWin = false
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { g in
            ZStack{
                Image("\(gameViewModel.backgroundImage)")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                
                VStack(spacing: 0) {
                    
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
                            Text("MAZE CHALLENGE")
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
                    //                    .padding(.vertical)
                    Spacer()
                    
                    VStack(spacing: 30){
                        SpriteView(scene: scene)
                            .frame(width: g.size.width * 0.9, height: g.size.width * 0.9)
                            .border(Color.white)
//                            .padding(.leading, 20)
                        
                        VStack{
                            // up
                            Button(action: { scene.movePlayer(dx: 0, dy: scene.moveStep) }) {
                                Image("button1")
                                    .resizable()
                                    .frame(width: g.size.width * 0.26, height: g.size.width * 0.2)
                            }
                            HStack(spacing: 5) {
                                //left
                                Button(action: { scene.movePlayer(dx: -scene.moveStep, dy: 0) }) {
                                    Image("button2")
                                        .resizable()
                                        .frame(width: g.size.width * 0.26, height: g.size.width * 0.2)
                                        .rotationEffect(.degrees(180))

                                }
                                //down
                                Button(action: { scene.movePlayer(dx: 0, dy: -scene.moveStep) }) {
                                    Image("button1")
                                        .resizable()
                                        .frame(width: g.size.width * 0.26, height: g.size.width * 0.2)
                                        .rotationEffect(.degrees(180))
                                }
                                // right
                                Button(action: { scene.movePlayer(dx: scene.moveStep, dy: 0) }) {
                                    Image("button2")
                                        .resizable()
                                        .frame(width: g.size.width * 0.26, height: g.size.width * 0.2)
                                }
                            }
                        }
                        

                    }
//                    .padding(.bottom)
                    .frame(width: g.size.width, height: g.size.height * 0.9)

                    
                }
                .frame(width: g.size.width, height: g.size.height)

            }

            .navigationBarBackButtonHidden()

        }

        
        
    }
}

