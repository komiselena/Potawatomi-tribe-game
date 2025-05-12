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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundView
                mainContent(geometry: geometry)
                overlayViews(geometry: geometry)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Subviews
    
    private var backgroundView: some View {
        Image("BG1")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private func mainContent(geometry: GeometryProxy) -> some View {
        VStack(spacing: 10) {
            headerView(geometry: geometry)
//            Spacer()
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
                        .fontWeight(.bold)
                        .font(.title)
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
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 5) {
                ForEach(Array(game.cards.enumerated()), id: \.element.id) { index, card in
                    CardView(card: card)
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.width * 0.25)
                        .onTapGesture {
                            handleCardTap(index)
                        }
                }
            }
        }
        .frame(height: geometry.size.height * 0.9)
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
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(.white)
                                .frame(width: geometry.size.width * 0.75, height: geometry.size.height * 0.08)
                            Text("BACK TO MAIN")
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                                .font(.title3)
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
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
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


/*
        
        GeometryReader { g in
            ZStack{
                Image("bg_main")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack(spacing: 0){

                    ZStack(alignment: .center){
                        BackgroundRectangle()
                            .frame(width: g.size.width , height: g.size.height * 0.9)

//                            .scaleEffect(2.8)
                        
                        VStack {
                            if game.lostMatch {
                                Image("Matches is wrong")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width * 0.3)
                                Button {
                                    game.restartGame()
                                    remainingAttempts = 5
                                } label: {
                                    Image("Retry")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: g.size.width * 0.18)

                                }


                            }else if game.allMatchesFound {
                                Image("All matches found")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width * 0.5)
                                    .onAppear{
                                        gameData.coins += 100

                                    }

                                HStack(spacing: 8) {
                                    ForEach(game.cards.prefix(6), id: \.id) { card in
                                        Image(card.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: g.size.width * 0.06)
                                            .cornerRadius(8)
                                    }
                                }
                                Image("Group 10")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width * 0.2)

                                Button {
                                    game.restartGame()
                                    remainingAttempts = 5

                                } label: {
                                    Image("Retry")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: g.size.width * 0.18)

                                }



                            }else {
                                ZStack{
                                    Image("Group 8")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: g.size.width * 0.15, height: g.size.height * 0.09)
                                    HStack{
                                        Image("coin")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: g.size.width * 0.05)
                                        Text("\(gameData.coins)")
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 10)
                                    }
                                    .frame(width: g.size.width * 0.15, height: g.size.height * 0.09)
                                }
                                
                                Image("Find a match")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: g.size.width * 0.3)
                                
                                
                                HStack {
                                    VStack {
                                        Text("TRIES: \(remainingAttempts)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    VStack {
                                        Text("TIME: \(timeLeft)")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(width: g.size.width * 0.45)
                                .padding()
                                
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 010) {
                                    ForEach(Array(game.cards.enumerated()), id: \.element.id) { index, card in
                                        CardView(card: card)
                                            .onTapGesture {
                                                handleCardTap(index)
                                            }
                                            .frame(width: g.size.width * 0.06, height: g.size.width * 0.06)
                                    }
                                }
                                .frame(width: g.size.width * 0.6)


                                
                            }
                            Spacer()
                        }
                        .padding(.top, g.size.height * 0.1)

                    }
                    .frame(height: g.size.height * 0.8)

                }

            }

            .onAppear(perform: startTimer)
            .onDisappear(perform: stopTimer)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image("crossButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: g.size.width * 0.1, height: g.size.width * 0.1)

                    }
                    
                    
                }

            }
            .frame(width: g.size.width, height: g.size.height)

            .navigationBarBackButtonHidden()

        }
        .navigationBarBackButtonHidden()


    }
    
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
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeLeft -= 1
            if timeLeft <= 0 {
                game.lostMatch = true
                stopTimer()
                gameOver()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func checkGameEnd() {
        if game.cards.allSatisfy({ $0.isMatched }) {
            game.allMatchesFound = true
            stopTimer()
        } else if remainingAttempts <= 0 {
            game.lostMatch = true
            gameOver()
        }
    }
    
    private func gameOver() {
        stopTimer()
    }
}


#Preview {
    MemoryGameView(gameData: GameData())
}

*/
