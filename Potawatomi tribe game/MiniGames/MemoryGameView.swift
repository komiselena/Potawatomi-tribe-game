//
//  MemoryMatchView.swift
//  Lucky Eagle Game
//
//  Created by Mac on 26.04.2025.
//

import SwiftUI

struct MemoryGameView: View {
    @StateObject private var game = MemoryGame(images: ["card1", "card2", "card3", "card4", "card5"])
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameData: GameData
    @State private var remainingAttempts = 5
    @State private var timeLeft = 45
    @State private var showReward = false
    @State private var timer: Timer?
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundView
                mainContent(geometry: geometry)

                overlayViews(geometry: geometry)
            }
            .frame(width: geometry.size.width , height: geometry.size.height)

        }
        .navigationBarBackButtonHidden()
    }
    
        // MARK: - Subviews
    
    private var backgroundView: some View {
        Image("\(gameViewModel.backgroundImage)")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private func mainContent(geometry: GeometryProxy) -> some View {
        VStack(spacing: 10) {
            headerView(geometry: geometry)
            Spacer()
            cardsGridView(geometry: geometry)

        }
        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
    }
    
    private func headerView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.09)
                
                HStack {
                    backButton
                    Spacer()
                    Text("CARD MATCH")
                        .foregroundStyle(.white)
                        .font(.title.weight(.heavy)) // Uses iOS's default title size + heavy weight
                    Spacer()
                    // Невидимая иконка для выравнивания
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundStyle(.clear)
                }
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.08)
            }
            
            HStack {
                Spacer()
                livesView
                Spacer()
            }
            .padding()
        }
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundStyle(.white)
        }
        .padding(.leading)
    }
    
    private var livesView: some View {
        HStack(spacing: 10) {
            ForEach(0..<5, id: \.self) { index in
                Image(systemName: index < remainingAttempts ? "heart.fill" : "heart")
                    .foregroundColor(index < remainingAttempts ? .white : .gray)
                    .font(.headline)
            }
        }
    }
    
    private func cardsGridView(geometry: GeometryProxy) -> some View {
        VStack {
            let columns = [GridItem(.flexible()), GridItem(.flexible())]
            let availableHeight = geometry.size.height * 0.6
            let spacing: CGFloat = 10
            let rows: CGFloat = 5
            let cardHeight = (availableHeight - (spacing * (rows - 1))) / rows

            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(Array(game.cards.enumerated()), id: \.element.id) { index, card in
                    CardView(card: card)
                        .frame(width: geometry.size.width * 0.38, height: cardHeight)
                        .onTapGesture {
                            handleCardTap(index)
                        }
                }
            }

        }
        .frame(height: geometry.size.height * 0.6)

    }
    private func cardsGridView2(geometry: GeometryProxy) -> some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        let spacing: CGFloat = 10
        let totalSpacing = spacing * 4 // если 5 строк, то 4 промежутка
        let availableHeight = geometry.size.height * 0.6 - totalSpacing
        let cardHeight = max(availableHeight / 5, 10) // минимальная высота 10

        return LazyVGrid(columns: columns, spacing: spacing) {
            ForEach(Array(game.cards.enumerated()), id: \.element.id) { index, card in
                CardView(card: card)
                    .frame(height: cardHeight)
                    .aspectRatio(0.75, contentMode: .fit) // ширина адаптируется
                    .onTapGesture {
                        handleCardTap(index)
                    }
            }
        }
        .frame(height: geometry.size.height * 0.6)
    }

    private func overlayViews(geometry: GeometryProxy) -> some View {
        Group {
            if game.lostMatch {
                lostMatchView(geometry: geometry)
            } else if game.allMatchesFound {
                ZStack{
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                    
                    
                    Image("Button-4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.4)
                        .onTapGesture {
                            dismiss()
                        }

                }
            }
        }
    }
    
    private func lostMatchView(geometry: GeometryProxy) -> some View {
        ZStack{
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                
                VStack {
                    Text("OOPS!")
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.heavy)) // Uses iOS's default title size + heavy weight

                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.08)
                            Text("BACK TO MAIN")
                                .foregroundStyle(.black)
                                .font(.title3.weight(.heavy)) // Uses iOS's default title size + heavy weight
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.35)
            }
        }
    }
    
    // MARK: - Game Logic
    
    private func handleCardTap(_ index: Int) {
        guard !showReward else { return }
        
        let previousMatched = game.cards.filter { $0.isMatched }.count
        game.flipCard(at: index)
        let currentMatched = game.cards.filter { $0.isMatched }.count
        
        if currentMatched == previousMatched && game.indexOfFirstCard == nil {
            remainingAttempts -= 1
        }
        
        checkGameEnd()
    }
    
    
    private func checkGameEnd() {
        if game.cards.allSatisfy({ $0.isMatched }) {
            game.allMatchesFound = true
            gameData.addCoins(30)
        } else if remainingAttempts <= 0 {
            game.lostMatch = true
        }
    }
    
}


struct CardView: View {
    var card: Card
    @State private var flipped = false
    @State private var rotation = 0.0
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            Group {
                if flipped {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.white)

                        Image(card.imageName)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.red)
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .padding(10)

                    }
                }
            }
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(scale)
        }
        .onChange(of: card.isFlipped || card.isMatched) { newValue in
            flipCard(to: newValue)
        }
    }
    
    private func flipCard(to isFlipped: Bool) {
        withAnimation(.easeInOut(duration: 0.2)) {
            rotation = 90
            scale = 1.05
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            flipped = isFlipped
            withAnimation(.easeInOut(duration: 0.2)) {
                rotation = 0
                scale = 1.0
            }
        }
    }
}

extension AnyTransition {
    static var flipFromLeft: AnyTransition {
        .modifier(
            active: FlipEffect(angle: 90),
            identity: FlipEffect(angle: 0)
        )
    }
}

struct FlipEffect: ViewModifier {
    var angle: Double

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 0.3), value: angle)
    }
}
