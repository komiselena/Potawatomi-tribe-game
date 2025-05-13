//
//  GameScene.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    
    // Textures
    var groundTile: SKTexture!
    var knightTexture: SKTexture!
    var horseTexture: SKTexture!
    var barrierTexture: SKTexture!
    var barnTexture: SKTexture!
    var bgTexture: SKTexture!
    var buttonUpTexture: SKTexture!
    var buttonDownTexture: SKTexture!
    var buttonRightTexture: SKTexture!
    var buttonLeftTexture: SKTexture!
    var throwButtonTexture: SKTexture!
    
    // Nodes
    var knight: SKSpriteNode!
    var background: SKSpriteNode!
    
    // Controls
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var throwButton: SKSpriteNode!
    
    // Game field
    var grid = [[Int]]()
    var knightPosition = (x: 0, y: 0)
    var facingDirection = "right"
    let tileSize: CGFloat = 60
    
    override func didMove(to view: SKView) {
        // Initialize grid (2 rows, 6 columns)
        grid = [
            [0, 1, 1, 1, 1, 1],  // Bottom row (y=0)
            [2, 4, 3, 1, 5, 1]   // Top row (y=1) - knight, barrier, horse, empty, barn, empty
        ]
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadTextures()
        setupBackground()
        setupLevel1()
        createControls()
    }
    
    func loadTextures() {
        groundTile = SKTexture(imageNamed: "Group 8")
        horseTexture = SKTexture(imageNamed: "horse")
        barrierTexture = SKTexture(imageNamed: "barrier")
        barnTexture = SKTexture(imageNamed: "barn")

        buttonUpTexture = SKTexture(imageNamed: "button1")
        buttonDownTexture = SKTexture(imageNamed: "button1")
        buttonRightTexture = SKTexture(imageNamed: "button2")
        buttonLeftTexture = SKTexture(imageNamed: "button2")
        throwButtonTexture = SKTexture(imageNamed: "button1")
    }
    
    func setupBackground() {
        background = SKSpriteNode(texture: bgTexture)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        background.size = self.size
        addChild(background)
    }
    
    func setupLevel1() {
        // Top row (y=1) - 6 tiles
        for x in 0..<6 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(
                x: CGFloat(x) * tileSize - 150,
                y: 70  // Higher position for top row
            )
            ground.size = CGSize(width: tileSize, height: tileSize)
            ground.name = "ground_1_\(x)"
            ground.zPosition = 0
            addChild(ground)
            
            // Add elements according to grid
            switch grid[1][x] {
            case 2: // Knight
                knight = SKSpriteNode(texture: knightTexture)
                knight.position = ground.position
                knight.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                knight.name = "knight"
                addChild(knight)
                knightPosition = (x: 0, y: 1)
                
            case 3: // Horse
                let horse = SKSpriteNode(texture: horseTexture)
                horse.position = ground.position
                horse.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                horse.name = "horse_\(x)_1"
                addChild(horse)
                
            case 4: // Barrier
                let barrier = SKSpriteNode(texture: barrierTexture)
                barrier.position = ground.position
                barrier.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                barrier.name = "barrier_\(x)_1"
                addChild(barrier)
                
            case 5: // Barn
                let barn = SKSpriteNode(texture: barnTexture)
                barn.position = ground.position
                barn.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                barn.name = "barn_\(x)_1"
                addChild(barn)
                
            default: break
            }
        }
        
        // Bottom row (y=0) - 6 tiles (first one is empty/blocked)
        for x in 0..<6 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(
                x: CGFloat(x) * tileSize - 150,
                y: (tileSize/1.6)  // Lower position for bottom row
            )
            ground.size = CGSize(width: tileSize, height: tileSize)
            ground.name = "ground_0_\(x)"
            ground.zPosition = 0
            addChild(ground)
            
            // First tile is blocked (no ground)
            if x == 0 {
                ground.alpha = 0.0  // Make it visually different
//                let blockedSign = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
//                blockedSign.position = ground.position
//                blockedSign.name = "blocked_0_0"
//                addChild(blockedSign)
            }
        }
    }
    
    func createControls() {
        let buttonSize = CGSize(width: UIScreen.main.bounds.size.width * 0.26, height: UIScreen.main.bounds.size.width * 0.2)
        
        // Up button
        upButton = SKSpriteNode(texture: buttonUpTexture)
        upButton.position = CGPoint(x: 0, y: -(UIScreen.main.bounds.size.width * 0.42))
        upButton.name = "up"
        upButton.size = buttonSize
        addChild(upButton)
        
        // Down button
        downButton = SKSpriteNode(texture: buttonDownTexture)
        downButton.position = CGPoint(x: 0, y: -(UIScreen.main.bounds.size.width * 0.64))
        downButton.name = "down"
        downButton.size = buttonSize
        downButton.yScale = -1
        addChild(downButton)
        
        // Left button
        leftButton = SKSpriteNode(texture: buttonLeftTexture)
        leftButton.position = CGPoint(x: -(UIScreen.main.bounds.size.width * 0.28), y: -(UIScreen.main.bounds.size.width * 0.64))
        leftButton.name = "left"
        leftButton.size = buttonSize
        leftButton.xScale = -1
        addChild(leftButton)
        
        // Right button
        rightButton = SKSpriteNode(texture: buttonRightTexture)
        rightButton.position = CGPoint(x: (UIScreen.main.bounds.size.width * 0.28), y: -(UIScreen.main.bounds.size.width * 0.64))
        rightButton.name = "right"
        rightButton.size = buttonSize
        addChild(rightButton)
        
        // Throw button
        throwButton = SKSpriteNode(color: .red, size: CGSize(width: UIScreen.main.bounds.size.width * 0.83, height: 70))
        throwButton.position = CGPoint(x: 0, y: -350)
        throwButton.name = "throw"
        
        let throwLabel = SKLabelNode(text: "THROW")
        throwLabel.fontName = "Arial-BoldMT"
        throwLabel.fontSize = 24
        throwLabel.fontColor = .white
        throwLabel.verticalAlignmentMode = .center
        throwLabel.position = CGPoint(x: 0, y: 0)
        throwButton.addChild(throwLabel)
        
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
        
        // Check boundaries and valid move
        guard newY >= 0, newY < grid.count,
              newX >= 0, newX < grid[newY].count,
              grid[newY][newX] == 1 else { return }
        
        // Update grid and position
        grid[knightPosition.y][knightPosition.x] = 1
        grid[newY][newX] = 2
        knightPosition = (x: newX, y: newY)
        
        // Calculate new position
        let newPos = CGPoint(
            x: CGFloat(newX) * tileSize - 150,
            y: newY == 0 ? 0 : 70  // Different y positions for rows
        )
        
        // Animate movement
        knight.run(SKAction.move(to: newPos, duration: 0.2))
        facingDirection = direction
    }
    
    func throwHorse() {
        let directions = ["up", "down", "left", "right"]
        
        for direction in directions {
            var x = knightPosition.x
            var y = knightPosition.y
            var horseFound = false
            var barnFound = false
            
            // Ищем коня в текущем направлении
            while true {
                switch direction {
                case "up": y += 1
                case "down": y -= 1
                case "left": x -= 1
                case "right": x += 1
                default: break
                }
                
                // Проверяем границы
                guard y >= 0, y < grid.count,
                      x >= 0, x < grid[y].count else { break }
                
                // Если нашли коня
                if grid[y][x] == 3 {
                    horseFound = true
                    break
                }
                
                // Если нашли загон
                if grid[y][x] == 5 {
                    barnFound = true
                    break
                }
                
                // Если упёрлись в препятствие (не пустая клетка)
                if grid[y][x] != 1 && grid[y][x] != 0 {
                    break
                }
            }
            
            // Если конь найден, двигаем его
            if horseFound {
                moveHorse(from: (x, y), direction: direction)
                return
            }
        }
    }
    func removeHorse(at position: (x: Int, y: Int)) {
        if let horse = childNode(withName: "horse_\(position.x)_\(position.y)") {
            horse.removeFromParent()
            grid[position.y][position.x] = 1
            
            // Wind animation
            let wind = SKSpriteNode(color: .cyan, size: CGSize(width: 10, height: 10))
            wind.position = knight.position
            wind.alpha = 0.7
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
            if row.contains(3) { return }
        }
        
        let label = SKLabelNode(text: "Level Complete!")
        label.fontSize = 40
        label.fontColor = .green
        label.position = CGPoint(x: 0, y: 0)
        addChild(label)
    }
    
    func moveHorse(from position: (x: Int, y: Int), direction: String) {
        var x = position.x
        var y = position.y
        var finalX = x
        var finalY = y
        
        // Ищем конечную позицию
        while true {
            switch direction {
            case "up": finalY += 1
            case "down": finalY -= 1
            case "left": finalX -= 1
            case "right": finalX += 1
            default: break
            }
            
            // Проверяем границы
            guard finalY >= 0, finalY < grid.count,
                  finalX >= 0, finalX < grid[finalY].count else {
                // Если вышли за границы, возвращаемся на последнюю допустимую клетку
                switch direction {
                case "up": finalY -= 1
                case "down": finalY += 1
                case "left": finalX += 1
                case "right": finalX -= 1
                default: break
                }
                break
            }
            
            // Если упёрлись в препятствие (не пустая клетка и не загон)
            if grid[finalY][finalX] != 1 && grid[finalY][finalX] != 5 {
                switch direction {
                case "up": finalY -= 1
                case "down": finalY += 1
                case "left": finalX += 1
                case "right": finalX -= 1
                default: break
                }
                break
            }
            
            // Если нашли загон, останавливаемся
            if grid[finalY][finalX] == 5 {
                break
            }
        }
        
        // Обновляем сетку и перемещаем коня
        grid[position.y][position.x] = 1 // Освобождаем старую позицию
        
        // Если конечная позиция - загон, удаляем коня
        if grid[finalY][finalX] == 5 {
            if let horse = childNode(withName: "horse_\(x)_\(y)") {
                horse.removeFromParent()
            }
            checkWin()
        } else {
            // Иначе перемещаем коня на новую позицию
            grid[finalY][finalX] = 3
            if let horse = childNode(withName: "horse_\(x)_\(y)") {
                horse.name = "horse_\(finalX)_\(finalY)"
                
                let newPos = CGPoint(
                    x: CGFloat(finalX) * tileSize - 150,
                    y: finalY == 0 ? 0 : 70
                )
                
                horse.run(SKAction.move(to: newPos, duration: 0.3))
            }
        }
        
        // Анимация "ветра" (стрелы)
        let wind = SKSpriteNode(color: .cyan, size: CGSize(width: 10, height: 10))
        wind.position = knight.position
        wind.alpha = 0.7
        addChild(wind)
        
        let path = CGMutablePath()
        path.move(to: knight.position)
        
        // Рассчитываем конечную точку ветра
        let windEndX = knight.position.x + CGFloat(finalX - position.x) * tileSize
        let windEndY = knight.position.y + CGFloat(finalY - position.y) * (finalY == 0 ? -70 : 70)
        path.addLine(to: CGPoint(x: windEndX, y: windEndY))
        
        wind.run(SKAction.sequence([
            SKAction.follow(path, asOffset: false, orientToPath: false, duration: 0.3),
            SKAction.removeFromParent()
        ]))
    }
}
