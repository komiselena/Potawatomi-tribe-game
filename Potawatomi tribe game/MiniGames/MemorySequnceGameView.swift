//
//  MemorySequnceGameView.swift
//  Lucky Eagle Game
//
//  Created by Mac on 27.04.2025.
//


import SwiftUI

struct MemorySequnceGameView: View {
    @StateObject private var viewModel = MemoryGameViewModel()
    @ObservedObject var gameData: GameData
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { g in
            ZStack{
                Image("\(gameViewModel.backgroundImage)")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                
                VStack(spacing: 10) {
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
                                Text("SIMON SAYS")
                                    .foregroundStyle(.white)
                                    .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
                                Spacer()
                                
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundStyle(.clear)
                            }
                            .frame(width: g.size.width * 0.9, height: g.size.height * 0.08)
                        }
                        //                    .padding(.vertical)
                        HStack{
                            Spacer()
                            Text("REMEMBER THE ORDER")
                                .foregroundStyle(.white)
                                .font(.headline)
                            Spacer()
                        }
                        .padding()
                    }
                    Spacer()

                    VStack(spacing: 0) {
                        if viewModel.showingSequence {
                            if let card = viewModel.showCard {
                                Image(card)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width * 0.8, height: g.size.width * 0.6)
                                    .transition(.scale)
                            }
                        } else {
                            let columns = [GridItem(.flexible()), GridItem(.flexible())]
                            let availableHeight = g.size.height * 0.6
                            let spacing: CGFloat = 10
                            let rows: CGFloat = 5
                            let cardHeight = (availableHeight - (spacing * (rows - 1))) / rows
                            
                            LazyVGrid(columns: columns, spacing: spacing) {
                                ForEach(["card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10"], id: \.self) { card in
                                    Button {
                                        viewModel.selectCard(card)
                                    } label: {
                                        Image(card)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: g.size.width * 0.38, height: cardHeight)
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: g.size.height * 0.6)
                }
                .frame(width: g.size.width * 0.9, height: g.size.height * 0.9)


            }
            .frame(width: g.size.width , height: g.size.height)
            .overlay{
                if viewModel.isGameOver && viewModel.isWon == false {
                    ZStack{
                        Color.black
                            .opacity(0.3)
                            .ignoresSafeArea()
                        VStack{
                            Spacer()
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.3)
                                VStack{
                                    Text("OOPS!")
                                        .foregroundStyle(.white)
                                        .font(.largeTitle.weight(.heavy)) // Uses iOS's default title size + heavy weight

                                    Button {
                                        dismiss()
                                    } label: {
                                        ZStack{
                                            Rectangle()
                                                .foregroundStyle(.white)
                                                .frame(width: g.size.width * 0.75, height: g.size.height * 0.08)
                                            Text("BACK TO MAIN")
                                                .foregroundStyle(.black)
                                                .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight

                                            
                                        }
                                    }
                                    
                                    
                                }
                                .frame(width: g.size.width * 0.75, height: g.size.height * 0.35)
                                
                            }
                            Spacer()
                        }
                    }
                } else if viewModel.isGameOver && viewModel.isWon {
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
            .onChange(of: viewModel.isWon) { newValue in
                if viewModel.isGameOver && viewModel.isWon {
                    gameData.addCoins(30)
                }
            }

            
            .onAppear {
                viewModel.startGame()
            }
            .animation(.easeInOut, value: viewModel.showCard)
            
            
            
        }
        .navigationBarBackButtonHidden()
        
    }
}


#Preview {
    MemorySequnceGameView(gameData: GameData(), gameViewModel: GameViewModel())
}
