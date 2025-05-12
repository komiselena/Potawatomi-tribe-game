//
//  GameScene.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2025.
//
import SpriteKit

class GameScene: SKScene {
    
    // Текстуры
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
    
    // Узлы
    var knight: SKSpriteNode!
    var background: SKSpriteNode!
    
    // Управление
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var throwButton: SKSpriteNode!
    
    // Игровое поле
    var grid = [[Int]]()
    var knightPosition = (x: 0, y: 0)
    var facingDirection = "right"
    let tileSize: CGFloat = 60
    
    override func didMove(to view: SKView) {
        // Инициализация сетки перед использованием
        grid = Array(repeating: Array(repeating: 0, count: 6), count: 2)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5) // Центрируем сцену
        loadTextures()
        setupBackground()
        setupLevel1()
        createControls()
    }
    
    func loadTextures() {
        // Проверяем загрузку всех текстур
        groundTile = SKTexture(imageNamed: "Group 8")
        knightTexture = SKTexture(imageNamed: "knight")
        horseTexture = SKTexture(imageNamed: "horse")
        barrierTexture = SKTexture(imageNamed: "barrier")
        barnTexture = SKTexture(imageNamed: "barn")
        bgTexture = SKTexture(imageNamed: "BG1")
        
        // Текстуры кнопок
        buttonUpTexture = SKTexture(imageNamed: "button1")
        buttonDownTexture = SKTexture(imageNamed: "button1")
        buttonRightTexture = SKTexture(imageNamed: "button2")
        buttonLeftTexture = SKTexture(imageNamed: "button2")
        
        // Красная кнопка для throw
        throwButtonTexture = SKTexture(imageNamed: "button1") // Временная текстура
    }
    
    func setupBackground() {
        background = SKSpriteNode(texture: bgTexture)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        background.size = self.size
        addChild(background)
    }
    
    func setupLevel1() {
        // Верхний ряд (y=1) - 6 клеток
        for x in 0..<6 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(
                x: CGFloat(x) * tileSize - 150,
                y: 50
            )
            ground.size = CGSize(width: tileSize, height: tileSize)
            ground.name = "ground_1_\(x)"
            ground.zPosition = 0
            addChild(ground)
            grid[1][x] = 1
            
            // Рыцарь в первой клетке (0,1)
            if x == 0 {
                knight = SKSpriteNode(texture: knightTexture)
                knight.position = ground.position
                knight.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                knight.name = "knight"
                addChild(knight)
                grid[1][0] = 2
                knightPosition = (x: 0, y: 1)
                
                // Преграда справа (1,1)
                let barrier = SKSpriteNode(texture: barrierTexture)
                barrier.position = CGPoint(
                    x: ground.position.x + tileSize,
                    y: ground.position.y
                )
                barrier.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                barrier.name = "barrier_1_1"
                addChild(barrier)
                grid[1][1] = 4
                
                // Лошадь через преграду (2,1)
                let horse = SKSpriteNode(texture: horseTexture)
                horse.position = CGPoint(
                    x: ground.position.x + 2 * tileSize,
                    y: ground.position.y
                )
                horse.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                horse.name = "horse_2_1"
                addChild(horse)
                grid[1][2] = 3
                
                // Загон через пустую клетку (4,1)
                let barn = SKSpriteNode(texture: barnTexture)
                barn.position = CGPoint(
                    x: ground.position.x + 4 * tileSize,
                    y: ground.position.y
                )
                barn.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                barn.name = "barn_4_1"
                addChild(barn)
                grid[1][4] = 5
            }
        }
        
        // Нижний ряд (y=0) - 5 клеток
        for x in 0..<5 {
            let ground = SKSpriteNode(texture: groundTile)
            ground.position = CGPoint(
                x: CGFloat(x) * tileSize - 120,
                y: -10
            )
            ground.size = CGSize(width: tileSize, height: tileSize)
            ground.name = "ground_0_\(x)"
            addChild(ground)
            grid[0][x] = 1
        }
    }
    
    func createControls() {
        let buttonSize = CGSize(width: UIScreen.main.bounds.size.width * 0.26, height: UIScreen.main.bounds.size.width * 0.2)
        
        // Кнопка вверх
        upButton = SKSpriteNode(texture: buttonUpTexture)
        upButton.position = CGPoint(x: 0, y: -(UIScreen.main.bounds.size.width * 0.42))
        upButton.name = "up"
        upButton.size = buttonSize
        addChild(upButton)
        
        // Кнопка вниз (перевернутая вверх)
        downButton = SKSpriteNode(texture: buttonDownTexture)
        downButton.position = CGPoint(x: 0, y: -(UIScreen.main.bounds.size.width * 0.64))
        downButton.name = "down"
        downButton.size = buttonSize
        downButton.yScale = -1 // Переворачиваем вертикально
        addChild(downButton)
        
        // Кнопка влево (перевернутая вправо)
        leftButton = SKSpriteNode(texture: buttonLeftTexture)
        leftButton.position = CGPoint(x: -(UIScreen.main.bounds.size.width * 0.28), y: -(UIScreen.main.bounds.size.width * 0.64))
        leftButton.name = "left"
        leftButton.size = buttonSize
        leftButton.xScale = -1 // Переворачиваем горизонтально
        addChild(leftButton)
        
        // Кнопка вправо
        rightButton = SKSpriteNode(texture: buttonRightTexture)
        rightButton.position = CGPoint(x: (UIScreen.main.bounds.size.width * 0.28), y: -(UIScreen.main.bounds.size.width * 0.64))
        rightButton.name = "right"
        rightButton.size = buttonSize
        addChild(rightButton)
        
        // Кнопка броска (красная с текстом)
        throwButton = SKSpriteNode(color: .red, size: CGSize(width: UIScreen.main.bounds.size.width * 0.83, height: 70))
        throwButton.position = CGPoint(x: 0, y: -350)
        throwButton.name = "throw"
        
        // Добавляем текст "THROW" на кнопку
        let throwLabel = SKLabelNode(text: "THROW")
        throwLabel.fontName = "Arial-BoldMT"
        throwLabel.fontSize = 24
        throwLabel.fontColor = .white
        throwLabel.verticalAlignmentMode = .center
        throwLabel.position = CGPoint(x: 0, y: 0)
        throwButton.addChild(throwLabel)
        
        addChild(throwButton)
    }
    
    // Остальные методы остаются без изменений
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
        
        guard newY >= 0, newY < grid.count,
              newX >= 0, newX < grid[newY].count,
              grid[newY][newX] == 1 else { return }
        
        grid[knightPosition.y][knightPosition.x] = 1
        grid[newY][newX] = 2
        knightPosition = (x: newX, y: newY)
        
        let newPos = CGPoint(
            x: CGFloat(newX) * tileSize - 150,
            y: newY == 0 ? -10 : 50
        )
        knight.run(SKAction.move(to: newPos, duration: 0.2))
        
        facingDirection = direction
    }
    
    func throwHorse() {
        var x = knightPosition.x
        var y = knightPosition.y
        
        // Двигаемся в направлении взгляда
        switch facingDirection {
        case "up": y += 1
        case "down": y -= 1
        case "left": x -= 1
        case "right": x += 1
        default: return
        }
        
        // Проверяем границы и наличие лошади
        guard y >= 0, y < grid.count,
              x >= 0, x < grid[y].count,
              grid[y][x] == 3 else { return }
        
        // Ищем загон в этом направлении
        var barnX = x
        var barnY = y
        
        while true {
            switch facingDirection {
            case "up": barnY += 1
            case "down": barnY -= 1
            case "left": barnX -= 1
            case "right": barnX += 1
            default: break
            }
            
            // Проверяем границы
            guard barnY >= 0, barnY < grid.count,
                  barnX >= 0, barnX < grid[barnY].count else { break }
            
            // Если нашли загон
            if grid[barnY][barnX] == 5 {
                removeHorse(at: (x, y))
                return
            }
            
            // Если на пути препятствие
            if grid[barnY][barnX] != 1 {
                break
            }
        }
    }
    
    func removeHorse(at position: (x: Int, y: Int)) {
        if let horse = childNode(withName: "horse_\(position.x)_\(position.y)") {
            horse.removeFromParent()
            grid[position.y][position.x] = 1
            
            // Анимация ветра
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
}
