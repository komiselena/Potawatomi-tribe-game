//
//  GameView.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//


import SwiftUI
import SpriteKit

struct GameView: UIViewRepresentable {
    let level: Int
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.ignoresSiblingOrder = true
        
//        let scene: BaseGameScene = GameScene(size: skView.bounds.size)
//        scene.scaleMode = .aspectFill
//        scene.levelNumber = level
//        
//        scene.completionHandler = {
//            // Здесь можно добавить логику перехода на следующий уровень
//            print("Level \(level) completed!")
//        }
//        
//        skView.presentScene(scene)
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {}
}
