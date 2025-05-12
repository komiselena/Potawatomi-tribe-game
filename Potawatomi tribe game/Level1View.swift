//
//  Level1View.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI
import SpriteKit

struct Level1View: View {
    @State private var gameScene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        GameView(level: 1)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    Level1View()
}
