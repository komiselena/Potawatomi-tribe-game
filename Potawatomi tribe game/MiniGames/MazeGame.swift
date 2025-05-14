//
//  MazeGame.swift
//  Lucky Eagle Game
//
//  Created by Mac on 26.04.2025.
//

import Foundation
import UIKit
import SpriteKit
import SwiftUI

class MazeGameScene: SKScene, ObservableObject {
    @Published var isWon = false
    
    private var mazeBackground: SKShapeNode!
    private var wallsNode: SKSpriteNode!
    private var playerNode: SKShapeNode!
    private var flagNode: SKSpriteNode! // Нода для флага
    private var trailNodes = [SKShapeNode]() // Массив для следов
    private var mazeCGImage: CGImage?
    private let playerRadius: CGFloat = 4
    let moveStep: CGFloat = 3
    private let startPoint = CGPoint(x: 10, y: 186)
    private let exitPoint = CGPoint(x: 186, y: 10)
    var onGameWon: (() -> Void)?
    
    // Настройки следа
    private let trailSquareSize: CGFloat = 6
    private let trailSpacing: CGFloat = 3
    private var lastTrailPosition: CGPoint?
    
    override func didMove(to view: SKView) {
        // 1. Красный фон с белой рамкой
        mazeBackground = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 196, height: 196))
        mazeBackground.fillColor = .red
        mazeBackground.strokeColor = .white
        mazeBackground.lineWidth = 2
        mazeBackground.position = CGPoint(x: 0, y: 0)
        addChild(mazeBackground)
        
        // 2. Векторные стены
        wallsNode = SKSpriteNode(imageNamed: "vector")
        wallsNode.anchorPoint = CGPoint(x: 0, y: 0)
        wallsNode.position = CGPoint(x: 0, y: 0)
        wallsNode.size = CGSize(width: 196, height: 196)
        addChild(wallsNode)
        
        // 3. Флаг в правом нижнем углу
        flagNode = SKSpriteNode(imageNamed: "flag")
        flagNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        flagNode.position = exitPoint // Используем exitPoint
        flagNode.zPosition = 1
        flagNode.size = CGSize(width: 20, height: 20)
        addChild(flagNode)

        // 4. Получаем CGImage для проверки стен
        if let img = UIImage(named: "vector")?.cgImage {
            mazeCGImage = img
        }

        // 5. Создаем игрока
        playerNode = SKShapeNode(circleOfRadius: playerRadius)
        playerNode.fillColor = .black
        playerNode.strokeColor = .clear
        playerNode.position = startPoint
        playerNode.zPosition = 2
        addChild(playerNode)
        
        // 6. Белая рамка вокруг шарика
        let squareOutline = SKShapeNode(rectOf: CGSize(width: playerRadius*3, height: playerRadius*3))
        squareOutline.strokeColor = .white
        squareOutline.lineWidth = 1
        squareOutline.fillColor = .white
        squareOutline.zPosition = -1
        playerNode.addChild(squareOutline)
    }
    
    func resetGame() {
        playerNode.position = startPoint
        // Удаляем все следы
        isWon = false
        trailNodes.forEach { $0.removeFromParent() }
        trailNodes.removeAll()
        lastTrailPosition = nil
    }
    
    func movePlayer(dx: CGFloat, dy: CGFloat) {
        let newPos = CGPoint(x: playerNode.position.x + dx, y: playerNode.position.y + dy)
        
        // Проверка выхода за пределы лабиринта
        guard mazeBackground.frame.contains(newPos) else { return }
        
        // Проверка столкновения со стенами
        if isWall(at: newPos) { return }
        
        // Проверка по точкам вокруг игрока
        let offsets: [CGPoint] = [
            CGPoint(x: playerRadius, y: 0), CGPoint(x: -playerRadius, y: 0),
            CGPoint(x: 0, y: playerRadius), CGPoint(x: 0, y: -playerRadius),
            CGPoint(x: playerRadius * 0.7, y: playerRadius * 0.7),
            CGPoint(x: -playerRadius * 0.7, y: playerRadius * 0.7),
            CGPoint(x: playerRadius * 0.7, y: -playerRadius * 0.7),
            CGPoint(x: -playerRadius * 0.7, y: -playerRadius * 0.7)
        ]
        
        for offset in offsets {
            if isWall(at: CGPoint(x: newPos.x + offset.x, y: newPos.y + offset.y)) {
                return
            }
        }
        
        // Обновляем позицию игрока
        playerNode.position = newPos
        
        // Добавляем след
        addTrail(at: newPos)
        
        // Проверка достижения флага
        if playerNode.position.distance(to: flagNode.position) < 15 {
            isWon = true
            print("is won \(isWon)")
            onGameWon?()
        }
    }
    
    private func addTrail(at position: CGPoint) {
        // Проверяем расстояние от последней точки следа
        if let lastPos = lastTrailPosition, position.distance(to: lastPos) < trailSpacing {
            return
        }
        
        // Создаем новый квадратик следа
        let trailDot = SKShapeNode(rectOf: CGSize(width: playerRadius*3, height: playerRadius*3))
        trailDot.position = position
        trailDot.fillColor = .white
        trailDot.strokeColor = .clear
        trailDot.zPosition = 0 // Между фоном и игроком
        
        addChild(trailDot)
        trailNodes.append(trailDot)
        lastTrailPosition = position
    }
    
    private func isWall(at point: CGPoint) -> Bool {
        guard let mazeCGImage = mazeCGImage else { return false }
        
        let scaleX = CGFloat(mazeCGImage.width) / wallsNode.size.width
        let scaleY = CGFloat(mazeCGImage.height) / wallsNode.size.height
        
        let imgX = Int(point.x * scaleX)
        let imgY = Int((wallsNode.size.height - point.y) * scaleY)
        
        guard imgX >= 0, imgX < mazeCGImage.width, imgY >= 0, imgY < mazeCGImage.height else {
            return true
        }
        
        guard let dataProvider = mazeCGImage.dataProvider,
              let pixelData = dataProvider.data,
              let data = CFDataGetBytePtr(pixelData) else {
            return true
        }
        
        let bytesPerPixel = mazeCGImage.bitsPerPixel / 8
        let bytesPerRow = mazeCGImage.bytesPerRow
        let pixelIndex = bytesPerRow * imgY + imgX * bytesPerPixel
        
        let totalBytes = CFDataGetLength(pixelData)
        guard pixelIndex >= 0, pixelIndex + 2 < totalBytes else {
            return true
        }
        
        let r = CGFloat(data[pixelIndex]) / 255.0
        let g = CGFloat(data[pixelIndex + 1]) / 255.0
        let b = CGFloat(data[pixelIndex + 2]) / 255.0
        
        return (r > 0.7 && g > 0.7 && b > 0.7)
    }
}

// Расширение для вычисления расстояния между точками
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(x - point.x, y - point.y)
    }
}
