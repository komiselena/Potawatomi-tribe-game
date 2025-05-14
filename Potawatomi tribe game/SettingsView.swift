//
//  SettingsView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 13.05.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameViewModel: GameViewModel
    @ObservedObject private var musicManager = MusicManager.shared

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
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.1)
                        
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
                                .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
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
                                .foregroundStyle(.white)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                            HStack{
                                Text("MUSIC")
                                    .foregroundStyle(.black)
                                    .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                    .padding()
                                Spacer()
                                Button {
                                    if !musicManager.paused {
                                        MusicManager.shared.pauseMusic()
                                    }else{
                                        MusicManager.shared.resumeMusic()
                                    }
                                } label: {
                                    Text(!musicManager.paused ? "ON" : "OFF")
                                        .foregroundStyle(.black)
                                        .opacity(!musicManager.paused ? 1.0 : 0.5)

                                        .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                        .padding()

                                }

                            }
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                            HStack{
                                Text("SOUNDS")
                                    .foregroundStyle(.black)
                                    .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                    .padding()
                                Spacer()
                                Button {
                                    if musicManager.soundsOn {
                                        musicManager.soundsOn = false
                                    }else{
                                        musicManager.soundsOn = true
                                    }
                                } label: {
                                    Text(musicManager.soundsOn ? "ON" : "OFF")
                                        .foregroundStyle(.black)
                                        .opacity(musicManager.soundsOn ? 1.0 : 0.5)
                                        .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                        .padding()

                                }

                            }
                        }
                        ZStack{
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(width: g.size.width * 0.9, height: g.size.height * 0.09)
                            HStack{
                                Text("VIBRO")
                                    .foregroundStyle(.black)
                                    .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                    .padding()
                                Spacer()
                                Button {
                                    // vibro ...
                                } label: {
                                    Text("OFF")
                                        .foregroundStyle(.black)
                                        .opacity(0.5)
                                        .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                        .padding()

                                }

                            }
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.1)
                                
                                Text("SAVE CHANGES")
                                    .foregroundStyle(.white)
                                    .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
                            }
                        }
                        
                    }
                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.8)

                }
                .frame(width: g.size.width * 0.9, height: g.size.height * 0.9)

            }
            .frame(width: g.size.width, height: g.size.height )

        }
        .navigationBarBackButtonHidden()
    }
}

