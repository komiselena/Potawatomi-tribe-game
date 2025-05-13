//
//  ShopView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 13.05.2025.
//

import SwiftUI

struct ShopView: View {
    
    enum Tab {
        case skins
        case backgrounds
    }

    @State private var selectedTab: Tab = .backgrounds
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var gameViewModel: GameViewModel

    @ObservedObject var gameData: GameData

    var body: some View {
        GeometryReader { g in
            ZStack {
                Image("\(gameViewModel.backgroundImage)")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
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
                            Text("SHOP")
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
                                .font(.title)
//                                    .padding(.trailing)
                            Spacer()
                        }
                        .frame(width: g.size.width * 0.29, height: g.size.height * 0.08)

                    }
                    .padding()

                    HStack{
                        Button(action: {
                            selectedTab = .backgrounds
                        }) {
                            ZStack{
                                Rectangle()
                                    .frame(width: g.size.width * 0.45, height: g.size.height * 0.08)
                                    .foregroundStyle(.white)
                                    .opacity(selectedTab == .backgrounds ? 1.0 : 0.6)
                                Text("BACKGROUNDS")
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .font(.title3)
                            }
                        }

                        Button(action: {
                            selectedTab = .skins
                        }) {
                            ZStack{
                                Rectangle()
                                    .frame(width: g.size.width * 0.45, height: g.size.height * 0.08)
                                    .foregroundStyle(.white)
                                    .opacity(selectedTab == .skins ? 1.0 : 0.6)
                                Text("SKINS")
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                    .font(.title3)
                            }
                        }
                        
                    }
                    Spacer()
                    
                    if selectedTab == .backgrounds {
                        VStack(spacing: 10){
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("BG1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("NIGHT CITY")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 1))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleBackgroundButton(id: 1)
                                    } label: {
                                        Text(currentBGButtonImage(for: 1))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("BG2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("FIELDS")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 2))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleBackgroundButton(id: 2)
                                    } label: {
                                        Text(currentBGButtonImage(for: 2))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("BG3")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("ISLAND")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 3))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleBackgroundButton(id: 3)
                                    } label: {
                                        Text(currentBGButtonImage(for: 3))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("BG4")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("SPACE")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 4))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleBackgroundButton(id: 4)
                                    } label: {
                                        Text(currentBGButtonImage(for: 4))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                                
                            }
                            
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.7)

                    }else{
                        VStack(spacing: 10){
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("skin1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("COWBOY")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 1))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleSkinButton(id: 1)
                                    } label: {
                                        Text(currentSkinButtonImage(for: 1))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("skin2")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("COWGIRL")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 2))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleSkinButton(id: 2)
                                    } label: {
                                        Text(currentSkinButtonImage(for: 2))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("skin3")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("AGENT")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 3))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleSkinButton(id: 3)
                                    } label: {
                                        Text(currentSkinButtonImage(for: 3))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: g.size.width * 0.9, height: g.size.height * 0.14)
                                HStack{
                                    Image("skin4")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: g.size.width * 0.2, height: g.size.width * 0.2)
                                        .clipped()
                                    
                                    VStack(alignment:.leading){
                                        Text("ROBOT")
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        Text(currentBGStatus(for: 4))
                                            .foregroundStyle(.white)
                                            .font(.callout)
                                    }
                                    Spacer()
                                    
                                    Button {
                                        handleSkinButton(id: 4)
                                    } label: {
                                        Text(currentSkinButtonImage(for: 4))
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .padding()
                                            .background {
                                                Rectangle()
                                                    .foregroundStyle(.white)
                                                
                                            }
                                        
                                        
                                    }
                                    
                                }
                                .frame(width: g.size.width * 0.85, height: g.size.height * 0.1)
                                
                            }
                            
                            
                        }
                        .frame(width: g.size.width * 0.9, height: g.size.height * 0.7)

                    }
                    
                    
                }
                .frame(width: g.size.width * 0.9, height: g.size.height * 0.9)


            }
            .navigationBarBackButtonHidden()
        }
    }
    private func handleSkinButton(id: Int) {
        if gameData.boughtSkinId.contains(id) {
            gameViewModel.skin = "skin\(id)"
            
            gameViewModel.objectWillChange.send() // Добавьте эту строку
        } else {
            if gameData.coins >= 100 {
                gameData.coins -= 100
                gameData.boughtSkinId.append(id)
            } else {
                print("Not enough money")
            }
        }
    }
    
    private func handleBackgroundButton(id: Int) {
        if gameData.boughtBackgroundId.contains(id)  {
            gameViewModel.backgroundImage = "BG\(id)"
            
            gameViewModel.objectWillChange.send() // Добавьте эту строку
        } else {
            if gameData.coins >= 100 {
                gameData.coins -= 100

                gameData.boughtBackgroundId.append(id)
//                gameViewModel.backgroundImage = "BG\(id)"
            } else {
                print("Not enough money")

            }
        }
    }
    
    private func currentSkinButtonImage(for id: Int) -> String {
        if gameData.boughtSkinId.contains(id) {
            return "CHOOSE"
        } else if gameViewModel.skin == "skin\(id)" {
            return ""
        } else{
            return "BUY"
        }
    }

    private func currentBGButtonImage(for id: Int) -> String {
        if gameData.boughtBackgroundId.contains(id) {
            return "CHOOSE"
        } else if gameViewModel.backgroundImage == "skin\(id)" {
            return ""
        } else{
            return "BUY"
        }
    }

    private func currentBGStatus(for id: Int) -> String {
        if gameData.boughtBackgroundId.contains(id) {
            return "Bought"
        } else if gameViewModel.backgroundImage == "skin\(id)" {
            return "Active"
        } else{
            return "100"
        }
    }
    private func currentSkinStatus(for id: Int) -> String {
        if gameData.boughtSkinId.contains(id) {
            return "Bought"
        } else if gameViewModel.skin == "skin\(id)" {
            return "Active"
        } else{
            return "100"
        }
    }

}

//#Preview {
//    ShopView()
//}
