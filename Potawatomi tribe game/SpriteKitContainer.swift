//
//  SpriteKitContainer.swift
//  Potawatomi tribe game
//
//  Created by Mac on 13.05.2025.
//

import SwiftUI
import SpriteKit

struct SpriteKitContainer: UIViewRepresentable {
    @EnvironmentObject var gameViewModel: GameViewModel

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        
        // Создаем сцену с правильным размером
        let scene = GameScene(size: CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        ))
        scene.scaleMode = .aspectFill
        scene.bgTexture = SKTexture(imageNamed: gameViewModel.backgroundImage)
        scene.knightTexture = SKTexture(imageNamed: gameViewModel.skin)
        view.presentScene(scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
}
