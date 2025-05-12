//
//  BaseGameScene.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//

import SwiftUI
import SpriteKit

class BaseGameScene: SKScene {
    // MARK: - Properties
    var levelNumber: Int = 1
    var completionHandler: (() -> Void)?
    
    // Textures
    var groundTile: SKTexture!
    var knight: SKSpriteNode!
    var horse: SKSpriteNode!
    var barrier: SKSpriteNode!
    var barn: SKSpriteNode!
    var bg: SKSpriteNode!

    // Nodes
    var background: SKSpriteNode!
    
    // Controls
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var throwButton: SKSpriteNode!
    
    // Game State
    var grid = [[Int]]()
    var knightPosition = (x: 0, y: 0)
    var facingDirection = "right"
    let tileSize: CGFloat = 60
    
    // MARK: - Scene Lifecycle
    override func didMove(to view: SKView) {
        loadTextures()
        setupBackground()
        setupLevel()
        createControls()
    }
    
    // MARK: - Setup Methods
    func loadTextures() {
        groundTile = SKTexture(imageNamed: "Group 8")
        knight = SKSpriteNode(imageNamed: "knight")
        horse = SKSpriteNode(imageNamed: "horse")
        barrier = SKSpriteNode(imageNamed: "barrier")
        barn = SKSpriteNode(imageNamed: "barn")
        bg = SKSpriteNode(imageNamed: "BG1")
    }
    
    func setupBackground() {
        bg = SKSpriteNode(imageNamed: "BG1")
        bg.zPosition = -1
        bg.size = self.size
        addChild(bg)
    }
    
    func setupLevel() {
        // Очищаем сетку
        grid = Array(repeating: Array(repeating: 0, count: 6), count: 2)
        
        // Верхний ряд (y=1) - 6 клеток
        for x in 0..<6 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(x: CGFloat(x) * tileSize - 150,
                                      y: 50)
            ground.size = CGSize(width: tileSize, height: tileSize)
            addChild(ground)
            grid[1][x] = 1 // Земля
            
            // Рыцарь в первой клетке (0,1)
            if x == 0 {
                knight = SKSpriteNode(imageNamed: "knight")
                knight.position = ground.position
                knight.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                addChild(knight)
                grid[1][0] = 2
                knightPosition = (x: 0, y: 1)
                
                // Преграда справа (1,1)
                barrier = SKSpriteNode(imageNamed: "barrier")
                barrier.position = CGPoint(x: ground.position.x + tileSize, y: ground.position.y)
                barrier.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                addChild(barrier)
                grid[1][1] = 4
                
                // Лошадь через преграду (2,1)
                horse = SKSpriteNode(imageNamed: "horse")
                horse.position = CGPoint(x: ground.position.x + 2 * tileSize, y: ground.position.y)
                horse.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                addChild(horse)
                grid[1][2] = 3
                
                // Загон через пустую клетку (4,1)
                barn = SKSpriteNode(imageNamed: "barn")
                barn.position = CGPoint(x: ground.position.x + 4 * tileSize, y: ground.position.y)
                barn.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                addChild(barn)
                grid[1][4] = 5
            }
        }
        
        // Нижний ряд (y=0) - 5 клеток (не используется в этом уровне)
        for x in 0..<5 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(x: CGFloat(x) * tileSize - 120,
                                      y: -10)
            ground.size = CGSize(width: tileSize, height: tileSize)
            addChild(ground)
            grid[0][x] = 1
        }
    }
    
    func createControls() {
        // Кнопки (используйте ваши текстуры)
        upButton = SKSpriteNode(imageNamed: "button1")
        upButton.position = CGPoint(x: -50, y: -200)
        upButton.name = "up"
        addChild(upButton)
        
        downButton = SKSpriteNode(imageNamed: "button1")
        downButton.zRotation = .pi
        downButton.position = CGPoint(x: -50, y: -270)
        downButton.name = "down"
        addChild(downButton)
        
        leftButton = SKSpriteNode(imageNamed: "button2")
        leftButton.zRotation = .pi
        leftButton.position = CGPoint(x: -110, y: -235)
        leftButton.name = "left"
        addChild(leftButton)
        
        rightButton = SKSpriteNode(imageNamed: "button2")
        rightButton.position = CGPoint(x: 10, y: -235)
        rightButton.name = "right"
        addChild(rightButton)
        
        throwButton = SKSpriteNode(color: .green, size: CGSize(width: 80, height: 60))
        throwButton.position = CGPoint(x: 100, y: -235)
        throwButton.name = "throw"
        addChild(throwButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        for node in nodes(at: location) {
            switch node.name {
            case "up": moveKnight(direction: "up")
            case "down": moveKnight(direction: "down")
            case "left": moveKnight(direction: "left")
            case "right": moveKnight(direction: "right")
            case "throw": throwHorse()
            default: break
            }
        }
    }
    
    func moveKnight(direction: String) {
        var newX = knightPosition.x
        var newY = knightPosition.y
        
        switch direction {
        case "up": newY += 1
        case "down": newY -= 1
        case "left": newX -= 1
        case "right": newX += 1
        default: return
        }
        
        // Проверка границ и препятствий
        guard newY >= 0, newY < grid.count,
              newX >= 0, newX < grid[newY].count,
              grid[newY][newX] == 1 else { return }
        
        // Обновляем позицию
        grid[knightPosition.y][knightPosition.x] = 1
        grid[newY][newX] = 2
        knightPosition = (x: newX, y: newY)
        
        // Анимация движения
        let newPos = CGPoint(
            x: CGFloat(newX) * tileSize - 150,
            y: newY == 0 ? -10 : 50
        )
        knight.run(SKAction.move(to: newPos, duration: 0.2))
        
        // Поворот рыцаря
        facingDirection = direction
        knight.zRotation = {
            switch direction {
            case "up": return .pi/2
            case "down": return -.pi/2
            case "left": return .pi
            default: return 0
            }
        }()
    }
    
    func throwHorse() {
        var x = knightPosition.x
        var y = knightPosition.y
        
        while true {
            // Двигаемся в направлении взгляда
            switch facingDirection {
            case "up": y += 1
            case "down": y -= 1
            case "left": x -= 1
            case "right": x += 1
            default: return
            }
            
            // Проверка границ
            guard y >= 0, y < grid.count, x >= 0, x < grid[y].count else { return }
            
            // Если нашли лошадь
            if grid[y][x] == 3 {
                // Ищем загон дальше
                var barnX = x, barnY = y
                while true {
                    switch facingDirection {
                    case "up": barnY += 1
                    case "down": barnY -= 1
                    case "left": barnX -= 1
                    case "right": barnX += 1
                    default: break
                    }
                    
                    guard barnY >= 0, barnY < grid.count,
                          barnX >= 0, barnX < grid[barnY].count else { break }
                    
                    if grid[barnY][barnX] == 5 { // Нашли загон
                        removeHorse(at: (x, y))
                        return
                    } else if grid[barnY][barnX] != 1 { // Препятствие
                        break
                    }
                }
            } else if grid[y][x] != 1 { // Препятствие
                return
            }
        }
    }
    
    func removeHorse(at position: (x: Int, y: Int)) {
        if let horse = childNode(withName: "horse") {
            horse.removeFromParent()
            grid[position.y][position.x] = 1
            
            // Анимация ветра
            let wind = SKSpriteNode(color: .cyan, size: CGSize(width: 10, height: 10))
            wind.position = knight.position
            addChild(wind)
            
            let path = CGMutablePath()
            path.move(to: knight.position)
            path.addLine(to: horse.position)
            
            wind.run(SKAction.sequence([
                SKAction.follow(path, asOffset: false, orientToPath: false, duration: 0.3),
                SKAction.removeFromParent()
            ]))
            
            checkWin()
        }
    }
    
    func checkWin() {
        for row in grid {
            if row.contains(3) { return } // Есть лошади
        }
        
        // Победа!
        let label = SKLabelNode(text: "Уровень пройден!")
        label.fontColor = .green
        addChild(label)
    }

    func createWindEffect(from start: CGPoint, to end: CGPoint) {
        let wind = SKSpriteNode(color: .cyan, size: CGSize(width: 10, height: 10))
        wind.position = start
        wind.alpha = 0.7
        addChild(wind)
        
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        
        wind.run(SKAction.sequence([
            SKAction.follow(path, asOffset: false, orientToPath: false, duration: 0.3),
            SKAction.removeFromParent()
        ]))
    }
    
    func checkLevelCompletion() {
        for row in grid {
            if row.contains(3) { return }
        }
        
        showLevelComplete()
    }
    
    func showLevelComplete() {
        let label = SKLabelNode(text: "Level \(levelNumber) Complete!")
        label.fontColor = .green
        label.fontSize = 40
        label.position = CGPoint(x: 0, y: 0)
        addChild(label)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.run { [weak self] in
                self?.completionHandler?()
            }
        ]))
    }
    
//    // MARK: - Touch Handling
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        
//        for node in nodes(at: location) {
//            switch node.name {
//            case "up": tryMoveKnight(direction: "up")
//            case "down": tryMoveKnight(direction: "down")
//            case "left": tryMoveKnight(direction: "left")
//            case "right": tryMoveKnight(direction: "right")
//            case "throw": throwHorse()
//            default: break
//            }
//        }
//    }
}
