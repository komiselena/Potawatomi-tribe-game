//
//  GameContainerView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI
import SpriteKit

struct GameContainerView: View {
    
    @State private var gameScene = GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        SpriteView(scene: gameScene)
            .ignoresSafeArea()

    }
    
}
