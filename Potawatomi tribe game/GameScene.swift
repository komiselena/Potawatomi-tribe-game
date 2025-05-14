//
//  GameScene.swift
//  Potawatomi tribe game
//
//  Created by Mac on 12.05.2022.
//
import SpriteKit
import SwiftUI

class GameScene: SKScene {
    var dismissAction: (() -> Void)?
    var gameViewModel: GameViewModel?
    
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
    
    // Nodes
    var knight: SKSpriteNode!
    var background: SKSpriteNode!
    var levelLabel: SKLabelNode!
    
    // Controls
    var upButton: SKSpriteNode!
    var downButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var throwButton: SKSpriteNode!
    var restartButton: SKSpriteNode!
    var backButton: SKSpriteNode!
    
    // Game field
    var initialGridData = [[Int]]()
    var grid = [[Int]]()
    var knightPosition = (x: 0, y: 1)
    var tileSize: CGFloat {
        // Базовый размер для iPhone
        let baseSize: CGFloat = 40
        
        // Определяем размер экрана
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = min(screenSize.width, screenSize.height)
        let screenHeight = max(screenSize.width, screenSize.height)
        
        // Множитель для iPad
        let iPadMultiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1.8 : 1.0
        
        // Дополнительный множитель для очень больших сеток
        let gridSizeMultiplier: CGFloat = {
            guard !initialGridData.isEmpty else { return 1.0 }
            let cols = initialGridData[0].count
            let rows = initialGridData.count
            
            // Если сетка очень большая (более 8 колонок или 8 строк), уменьшаем размер
            if cols > 8 || rows > 8 {
                return 0.8
            }
            return 1.0
        }()
        
        // Итоговый размер с учетом всех факторов
        return baseSize * iPadMultiplier * gridSizeMultiplier
    }

    var rowSpacing: CGFloat {
        return tileSize * 0.56
    }

    var entityYOffset: CGFloat {
        return tileSize * 0.4
    }

    // Level management
    var currentLevel = 1
    let totalLevels = 10
    var levelData: [Int: [[[Int]]]] = [:]
    
    let yForRow0: CGFloat = 37.5
    let yForRow1: CGFloat = 95.0
    
    override func didMove(to view: SKView) {
        setupLevelData()
        if let currentLevel = gameViewModel?.currentLevel {
            initialGridData = levelData[currentLevel]?[0] ?? []
        }
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadTextures()
        setupGame(isRestart: false)
    }
    func setupLevelData() {
        levelData = [
            1: [
                [[6, 1, 1, 1, 1, 1],
                 [2, 4, 3, 1, 5, 1]]
                
            ],
            
            2: [
                [[1, 1, 1, 5, 1, 1, 1],
                 [1, 1, 1, 3, 1, 1, 1],
                 [1, 1, 4, 4, 4, 1, 1],
                 [5, 3, 4, 2, 4, 3, 5],
                 [1, 1, 4, 4, 4, 1, 1],
                 [1, 1, 1, 3, 1, 1, 1],
                 [1, 1, 1, 5, 1, 1, 1]
                 
                ]
                
            ],
            3 : [
                [
                    [1, 1, 1, 1, 1, 4, 2, 1, 1],
                    [4, 4, 4, 4, 4, 4, 4, 4, 1],
                    [1, 5, 3, 1, 5, 3, 1, 1, 1],
                ]
            ],
            4 : [
                [
                    [1, 1, 1, 5, 6],
                    [2, 3, 1, 3, 1],
                    [1, 1, 1, 1, 1],
                    [5, 3, 1, 1, 1],
                    [1, 5, 1, 1, 1],
                    
                    
                ]
            ],
            5: [
                [
                    [6, 1, 1, 1, 1, 1],
                    [4, 1, 1, 3, 1, 1],
                    [6, 2, 1, 1, 1, 1],
                    [1, 1, 1, 1, 5, 1],
                    [1, 4, 1, 1, 1, 6],
                    [1, 1, 1, 1, 6, 6],
                ]
            ],
            6: [
                [
                    [6, 6, 1, 1, 6, 6, 6, 6, 6, 6],
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    [1, 2, 1, 1, 4, 1, 1, 3, 1, 6],
                    [1, 4, 1, 1, 1, 1, 1, 1, 1, 1],
                    [1, 1, 1, 4, 1, 1, 1, 1, 1, 6],
                    [1, 1, 1, 4, 1, 1, 4, 4, 4, 6],
                    [1, 1, 1, 1, 1, 1, 5, 1, 1, 6],
                    [1, 1, 1, 1, 1, 1, 1, 4, 4, 6],
                    [1, 4, 4, 1, 1, 1, 1, 1, 1, 6],
                    [1, 6, 1, 6, 1, 6, 1, 6, 6, 6]
                    
                ]
            ],
            7: [
                [
                    [1, 1, 5, 1, 1, 1, 5, 1, 1],
                    [1, 1, 4, 1, 2, 1, 4, 1, 1],
                    [4, 1, 3, 1, 1, 1, 3, 1, 4],
                    [1, 1, 1, 1, 1, 1, 1, 1, 1],
                    [6, 6, 6, 6, 1, 6, 6, 6, 6],
                    [1, 1, 3, 4, 1, 4, 3, 1, 1],
                    [5, 1, 1, 4, 1, 4, 1, 1, 5],
                    [6, 1, 1, 6, 6, 6, 1, 1, 6],
                    
                ]
            ],
            8: [
                [
                    [1, 1, 1, 1, 1, 1, 5],
                    [1, 1, 1, 3, 5, 1, 1],
                    [1, 3, 1, 3, 1, 5, 1],
                    [1, 1, 1, 1, 1, 1, 1],
                    [1, 1, 1, 1, 1, 1, 1],
                    [1, 5, 1, 3, 1, 3, 1],
                    [1, 1, 5, 3, 1, 1, 1],
                    [5, 1, 1, 2, 1, 1, 1],
                    
                    
                ]
            ],
            9:
                [
                    [
                        [6, 1, 1, 1, 1, 1, 1, 1, 4, 1],
                        [6, 1, 1, 1, 3, 1, 1, 1, 4, 1],
                        [1, 1, 1, 3, 1, 1, 1, 1, 4, 1],
                        [1, 5, 1, 1, 2, 1, 5, 1, 1, 1],
                        [1, 1, 4, 4, 1, 1, 1, 4, 1, 6],
                        [1, 1, 1, 1, 1, 1, 1, 1, 1, 6],
                        
                    ]
                ],
            10: [
                [
                    [6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6],
                    [1, 1, 1, 1, 4, 1, 1, 1, 3, 3, 1],
                    [1, 3, 1, 1, 4, 1, 1, 1, 1, 1, 1],
                    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                    [1, 1, 1, 1, 5, 1, 3, 1, 2, 1, 1],
                    [1, 1, 1, 5, 1, 5, 1, 1, 1, 1, 1],
                    [1, 4, 1, 1, 5, 1, 1, 1, 1, 1, 1],
                    [1, 1, 1, 4, 1, 1, 1, 1, 1, 4, 1],
                    [1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1],
                    [6, 6, 6, 6, 6, 1, 1, 1, 1, 1, 1],
                    
                ]
            ]
            // Add more levels as needed
        ]
        
        // Убедимся, что currentLevel установлен правильно
        if let currentLevel = gameViewModel?.currentLevel {
            initialGridData = levelData[currentLevel]?[0] ?? []
        }
    }
    
    
    func setupGame(isRestart: Bool) {
        // Полностью очищаем сцену
        self.removeAllChildren()
        self.removeAllActions()
        
        // Перезагружаем данные уровня
        grid = initialGridData.map { $0 }
        knightPosition = (x: 0, y: 1)
        
        setupBackground()
        setupHeader()
        setupCurrentLevel()
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
    }
    
    func setupBackground() {
        background = SKSpriteNode(texture: bgTexture)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -100
        background.size = self.size
        addChild(background)
    }
    
    func setupCurrentLevel() {
        guard !grid.isEmpty else { return }
        
        let numCols = grid[0].count
        let numRows = grid.count
        // Рассчитываем общий размер сетки
        let gridWidth = CGFloat(numCols) * tileSize
        let gridHeight = CGFloat(numRows) * rowSpacing
        
        let maxGridWidth = size.width * 0.9
        let maxGridHeight = size.height * 0.7
        
        
        // Если сетка слишком большая, масштабируем tileSize
        var adjustedTileSize = tileSize
        if gridWidth > maxGridWidth || gridHeight > maxGridHeight {
            let widthScale = maxGridWidth / gridWidth
            let heightScale = maxGridHeight / gridHeight
            let scale = min(widthScale, heightScale)
            adjustedTileSize *= scale
        }
        
        
        // Пересчитываем размеры с учетом возможного масштабирования
        let adjustedGridWidth = CGFloat(numCols) * adjustedTileSize
        let adjustedGridHeight = CGFloat(numRows) * (adjustedTileSize * 0.56)
        
        // Центрируем игровое поле
        let startX = -adjustedGridWidth / 2 + adjustedTileSize / 2
        let startY = -adjustedGridHeight / 2 + 100 // 100 - отступ для header
        
        // Find knight position
        var knightFound = false
        var knightGridX = 0
        var knightGridY = 0
        
        // Create all ground tiles first
        for r in 0..<numRows {
            let yPos = startY + CGFloat(r) * rowSpacing
            
            for c in 0..<numCols {
                let ground = SKSpriteNode(texture: groundTile)
                ground.position = CGPoint(x: startX + CGFloat(c) * tileSize, y: yPos)
                ground.size = CGSize(width: tileSize, height: tileSize)
                ground.zPosition = CGFloat(-r) // Нижние ряды имеют более низкий zPosition
                if grid[r][c] == 6 { ground.alpha = 0.0 }
                addChild(ground)
                
                if grid[r][c] == 2 {
                    knightGridX = c
                    knightGridY = r
                    knightFound = true
                }
            }
        }
        
        // Create entities
        for r in 0..<numRows {
            let yPos = startY + CGFloat(r) * rowSpacing
            
            for c in 0..<numCols {
                let position = CGPoint(x: startX + CGFloat(c) * tileSize,
                                       y: yPos + entityYOffset)
                
                var entity: SKSpriteNode?
                switch grid[r][c] {
                case 2: // Knight
                    if knightFound && c == knightGridX && r == knightGridY {
                        knight = SKSpriteNode(texture: knightTexture)
                        entity = knight
                        knight.name = "knight"
                        knightPosition = (x: c, y: r)
                        // Устанавливаем высокий zPosition для рыцаря
                        entity?.zPosition = 100 // Больше чем у всех других объектов
                    }
                case 3: // Horse
                    entity = SKSpriteNode(texture: horseTexture)
                    entity?.name = "horse_\(c)_\(r)"
                case 4: // Barrier
                    entity = SKSpriteNode(texture: barrierTexture)
                    entity?.name = "barrier_\(c)_\(r)"
                    entity?.zPosition = CGFloat(r) + 0.5 // Меньше чем у рыцаря
                case 5: // Barn
                    entity = SKSpriteNode(texture: barnTexture)
                    entity?.name = "barn_\(c)_\(r)"
                default: break
                }
                
                if let entity = entity {
                    entity.position = position
                    entity.size = CGSize(width: tileSize * 0.8, height: tileSize * 0.8)
                    entity.zPosition = CGFloat(r) + 0.5
                    addChild(entity)
                }
            }
        }
        
        if !knightFound {
            knightPosition = (x: 0, y: 1)
        }
    }
    func backToLevelSelection() {
        dismissAction?()
    }
    
    func showMessage(_ text: String, completion: (() -> Void)? = nil) {
        let message = SKLabelNode(text: text)
        message.fontSize = 40
        message.fontColor = .green
        message.position = CGPoint(x: 0, y: 0)
        message.zPosition = 20
        message.alpha = 0
        addChild(message)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 1.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        
        var sequence = [fadeIn, wait, fadeOut, remove]
        
        if let completion = completion {
            sequence.append(SKAction.run {
                completion()
            })
        }
        
        message.run(SKAction.sequence(sequence))
    }
    
    
    
    func loadLevel(_ level: Int) {
        guard level >= 1 && level <= totalLevels else { return }
        
        currentLevel = level
        if let level = levelData[currentLevel]?[0] {
            initialGridData = level
        }
        
        setupGame(isRestart: true)
    }
    
    func nextLevel() {
        let nextLevel = (gameViewModel?.currentLevel ?? 1) + 1
        if nextLevel <= totalLevels {
            gameViewModel?.currentLevel = nextLevel
//            gameViewModel?.unlockNextLevel()
            
            // Полностью перезагружаем уровень
            initialGridData = levelData[nextLevel]?[0] ?? []
            setupGame(isRestart: true)
            
            // Обновляем текст уровня
            levelLabel.text = "LEVEL \(nextLevel)"
            
            print("Current level: \(nextLevel), Unlocked levels: \(gameViewModel?.unlockedLevels ?? 1)")
        } else {
            showMessage("Game Completed!")
        }
    }
    func setupHeader() {
        // Определяем базовый размер для масштабирования
        let baseWidth: CGFloat = 375 // Ширина iPhone 8 (базовый размер для масштабирования)
        let scaleFactor = size.width / baseWidth
        
        // Header background (используем фиксированный размер относительно экрана)
        let headerWidth = size.width * 0.83
        let headerHeight: CGFloat = 50 * scaleFactor
        let header = SKSpriteNode(color: .red, size: CGSize(width: headerWidth, height: headerHeight))
        header.position = CGPoint(x: 0, y: size.height/2 - header.size.height * 1.6)
        header.zPosition = 10
        addChild(header)
        
        // Back button
        let buttonSize = CGSize(width: 40 * scaleFactor, height: 40 * scaleFactor)
        let buttonOffset = headerWidth/2 - buttonSize.width/2 - 10 * scaleFactor
        
        backButton = SKSpriteNode(color: .clear, size: buttonSize)
        backButton.position = CGPoint(x: -buttonOffset, y: header.position.y)
        backButton.name = "back"
        backButton.zPosition = 11
        
        let backLabel = SKLabelNode(text: "←")
        backLabel.fontName = "SF Pro"
        backLabel.fontSize = 24 * scaleFactor
        backLabel.verticalAlignmentMode = .center
        backLabel.horizontalAlignmentMode = .center
        backLabel.position = CGPoint(x: 0, y: -5 * scaleFactor) // Небольшая вертикальная корректировка
        backButton.addChild(backLabel)
        addChild(backButton)
        
        // Level label
        levelLabel = SKLabelNode(text: "LEVEL \(gameViewModel?.currentLevel ?? 1)")
        levelLabel.fontName = "Arial-BoldMT"
        levelLabel.fontSize = 24 * scaleFactor
        levelLabel.fontColor = .white
        levelLabel.position = CGPoint(x: 0, y: header.position.y - 10 * scaleFactor)
        levelLabel.zPosition = 11
        addChild(levelLabel)
        
        // Restart button
        restartButton = SKSpriteNode(color: .clear, size: buttonSize)
        restartButton.position = CGPoint(x: buttonOffset, y: header.position.y)
        restartButton.name = "restart"
        restartButton.zPosition = 11
        
        let restartLabel = SKLabelNode(text: "↻")
        restartLabel.fontName = "System"
        restartLabel.fontSize = 28 * scaleFactor
        restartLabel.verticalAlignmentMode = .center
        restartLabel.horizontalAlignmentMode = .center
        restartLabel.position = CGPoint(x: 0, y: -5 * scaleFactor) // Небольшая вертикальная корректировка
        restartButton.addChild(restartLabel)
        addChild(restartButton)
    }
    
    func createControls() {
        // Определяем размеры экрана
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // Размеры кнопок
        let directionButtonSize: CGSize
        let throwButtonSize: CGSize
        
        // Отступы и позиционирование
        let throwButtonBottomMargin: CGFloat
        let controlsBottomMargin: CGFloat
        let horizontalSpacing: CGFloat
        
        // Настройки для разных устройств
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Настройки для iPad
            directionButtonSize = CGSize(width: screenWidth * 0.15, height: screenWidth * 0.15)
            throwButtonSize = CGSize(width: screenWidth * 0.8, height: 70)
            throwButtonBottomMargin = 60
            controlsBottomMargin = throwButtonBottomMargin + throwButtonSize.height + 50
            horizontalSpacing = directionButtonSize.width * 1.2
        } else {
            // Настройки для iPhone (всех моделей)
            directionButtonSize = CGSize(width: screenWidth * 0.24, height: screenWidth * 0.24)
            throwButtonSize = CGSize(width: screenWidth * 0.83, height: 60)
            throwButtonBottomMargin = 40
            controlsBottomMargin = throwButtonBottomMargin + throwButtonSize.height + 30
            horizontalSpacing = directionButtonSize.width * 1.2
        }
        
        // Позиция кнопки Throw (фиксированный отступ от низа)
        let throwButtonY = -screenHeight/2 + throwButtonBottomMargin + throwButtonSize.height/2
        
        // Позиция центра управления (выше кнопки Throw)
        let controlsCenterY = -screenHeight/2 + controlsBottomMargin + directionButtonSize.height * 1.5
        
        // Создаем кнопку Throw (в самом низу)
        throwButton = SKSpriteNode(color: .red, size: throwButtonSize)
        throwButton.position = CGPoint(x: 0, y: throwButtonY)
        throwButton.name = "throw"
        throwButton.zPosition = 2
        
        let throwLabel = SKLabelNode(text: "THROW")
        throwLabel.fontName = "Arial-BoldMT"
        throwLabel.fontSize = UIDevice.current.userInterfaceIdiom == .pad ? 30 : 24
        throwLabel.fontColor = .white
        throwLabel.verticalAlignmentMode = .center
        throwLabel.position = CGPoint(x: 0, y: 0)
        throwButton.addChild(throwLabel)
        addChild(throwButton)
        
        // Создаем кнопки управления (выше кнопки Throw)
        // Кнопка вверх
        upButton = SKSpriteNode(texture: buttonUpTexture)
        upButton.position = CGPoint(x: 0, y: controlsCenterY)
        upButton.name = "up"
        upButton.size = directionButtonSize
        upButton.zPosition = 2
        addChild(upButton)
        
        // Кнопка вниз
        downButton = SKSpriteNode(texture: buttonDownTexture)
        downButton.position = CGPoint(x: 0, y: controlsCenterY - directionButtonSize.height * 1.2)
        downButton.name = "down"
        downButton.size = directionButtonSize
        downButton.yScale = -1
        downButton.zPosition = 2
        addChild(downButton)
        
        // Кнопка влево
        leftButton = SKSpriteNode(texture: buttonLeftTexture)
        leftButton.position = CGPoint(x: -horizontalSpacing,
                                    y: controlsCenterY - directionButtonSize.height * 1.2)
        leftButton.name = "left"
        leftButton.size = directionButtonSize
        leftButton.xScale = -1
        leftButton.zPosition = 2
        addChild(leftButton)
        
        // Кнопка вправо
        rightButton = SKSpriteNode(texture: buttonRightTexture)
        rightButton.position = CGPoint(x: horizontalSpacing,
                                     y: controlsCenterY - directionButtonSize.height * 1.2)
        rightButton.name = "right"
        rightButton.size = directionButtonSize
        rightButton.zPosition = 2
        addChild(rightButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "up" { moveKnight(direction: "up"); return }
            if node.name == "down" { moveKnight(direction: "down"); return }
            if node.name == "left" { moveKnight(direction: "left"); return }
            if node.name == "right" { moveKnight(direction: "right"); return }
            if node.name == "throw" { performThrowAction(); return }
            if node.name == "restart" { restartLevel(); return }
            if node.name == "back" { backToLevelSelection(); return }
            
            // Handle modal buttons
            if node.name == "nextLevelButton" || node.name == "modalBackButton" {
                handleModalButtonTouched(node)
                return
            }
        }
    }
    func restartLevel() {
        setupGame(isRestart: true)
    }
    
    func showLevelCompleteModal() {
        let dimBackground = SKSpriteNode(color: .black, size: self.size)
        dimBackground.position = CGPoint(x: 0, y: 0)
        dimBackground.zPosition = 99
        dimBackground.alpha = 0.3
        dimBackground.name = "dimBackground"
        addChild(dimBackground)
        
        // Create red modal background (немного большего размера)
        let modalBackground = SKSpriteNode(color: .red, size: CGSize(width: 340, height: 280))
        modalBackground.position = CGPoint(x: 0, y: 0)
        modalBackground.zPosition = 100
        modalBackground.name = "levelCompleteModal"
        addChild(modalBackground)
        
        // Add stars image
        let stars = SKSpriteNode(imageNamed: "stars")
        stars.position = CGPoint(x: 0, y: 140)
        stars.zPosition = 101
        stars.size = CGSize(width: 250, height: 110)
        modalBackground.addChild(stars)
        
        // Add level complete label (белый цвет)
        let completeLabel = SKLabelNode(text: "LEVEL COMPLETED")
        completeLabel.fontSize = 30
        completeLabel.fontColor = .white
        completeLabel.fontName = "Arial-BoldMT"
        completeLabel.position = CGPoint(x: 0, y: 20)
        completeLabel.zPosition = 101
        completeLabel.name = "levelCompleteModal"
        modalBackground.addChild(completeLabel)
        
        // Next level button (белый прямоугольник с черным текстом)
        let nextLevelButton = SKSpriteNode(color: .white, size: CGSize(width: 280, height: 55))
        nextLevelButton.position = CGPoint(x: 0, y: -40)
        nextLevelButton.zPosition = 101
        nextLevelButton.name = "nextLevelButton"
        
        let nextLabel = SKLabelNode(text: "NEXT LEVEL")
        nextLabel.fontSize = 20
        nextLabel.fontColor = .black
        nextLabel.fontName = "Arial-BoldMT"
        nextLabel.verticalAlignmentMode = .center
        nextLabel.horizontalAlignmentMode = .center
        nextLabel.position = CGPoint(x: 0, y: 0)
        nextLevelButton.addChild(nextLabel)
        modalBackground.addChild(nextLevelButton)
        
        // Back to menu button (белый прямоугольник с черным текстом)
        let backButton = SKSpriteNode(color: .white, size: CGSize(width: 280, height: 55))
        backButton.position = CGPoint(x: 0, y: -100)
        backButton.zPosition = 101
        backButton.name = "modalBackButton"
        
        let backLabel = SKLabelNode(text: "BACK TO MENU")
        backLabel.fontSize = 20
        backLabel.fontColor = .black
        backLabel.fontName = "Arial-BoldMT"
        backLabel.verticalAlignmentMode = .center
        backLabel.horizontalAlignmentMode = .center
        backLabel.position = CGPoint(x: 0, y: 0)
        backButton.addChild(backLabel)
        modalBackground.addChild(backButton)
    }
    
    func handleModalButtonTouched(_ node: SKNode) {
        // Удаляем затемнение и модальное окно
        self.enumerateChildNodes(withName: "dimBackground") { node, _ in
            node.removeFromParent()
        }
        self.enumerateChildNodes(withName: "levelCompleteModal") { node, _ in
            node.removeFromParent()
        }
        
        if node.name == "nextLevelButton" {
            nextLevel()
        } else if node.name == "modalBackButton" {
            backToLevelSelection()
        }
    }
    
    func moveKnight(direction: String) {
        var newGridX = knightPosition.x
        var newGridY = knightPosition.y
        switch direction {
        case "up": newGridY += 1
        case "down": newGridY -= 1
        case "left": newGridX -= 1
        case "right": newGridX += 1
        default: return
        }
        
        guard grid.indices.contains(newGridY), grid[newGridY].indices.contains(newGridX) else { return }
        if newGridY == 0 && (grid[newGridY][newGridX] == 6 || grid[newGridY][newGridX] != 1) { return }
        let targetTileType = grid[newGridY][newGridX]
        guard targetTileType == 1 else { return }
        
        grid[knightPosition.y][knightPosition.x] = 1
        grid[newGridY][newGridX] = 2
        knightPosition = (x: newGridX, y: newGridY)
        
        let moveAction = SKAction.move(to: getVisualPosition(gridX: newGridX, gridY: newGridY), duration: 0.2)
        // Сохраняем высокий zPosition при движении
        knight.zPosition = 100
        knight.run(moveAction)
    }
    func performThrowAction() {
        let directions: [(dx: Int, dy: Int, name: String)] = [
            (0, 1, "up"),
            (0, -1, "down"),
            (-1, 0, "left"),
            (1, 0, "right")
        ]
        
        for direction in directions {
            // Create wind/arrow animation in this direction
            animateWind(direction: direction)
            
            // Check for horse in this direction
            checkAndMoveHorse(direction: direction)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkWin()
            }
            
        }
    }
    
    func animateWind(direction: (dx: Int, dy: Int, name: String)) {
        let windSize = CGSize(width: tileSize * 0.3, height: tileSize * 0.1)
        let wind = SKShapeNode(rect: CGRect(origin: CGPoint(x: -windSize.width/2, y: -windSize.height/2),
                                            size: windSize),
                               cornerRadius: windSize.height/2)
        wind.fillColor = .white
        wind.strokeColor = .clear
        wind.position = knight.position
        wind.zPosition = 5
        addChild(wind)
        
        // Calculate end position (edge of the screen in this direction)
        let maxDistance = max(frame.width, frame.height)
        let endPosition: CGPoint
        
        switch direction.name {
        case "up":
            endPosition = CGPoint(x: knight.position.x, y: knight.position.y + maxDistance)
            wind.zRotation = .pi / 2
        case "down":
            endPosition = CGPoint(x: knight.position.x, y: knight.position.y - maxDistance)
            wind.zRotation = -.pi / 2
        case "left":
            endPosition = CGPoint(x: knight.position.x - maxDistance, y: knight.position.y)
            wind.zRotation = .pi
        case "right":
            endPosition = CGPoint(x: knight.position.x + maxDistance, y: knight.position.y)
            wind.zRotation = 0
        default:
            endPosition = knight.position
        }
        
        let moveAction = SKAction.move(to: endPosition, duration: 0.5)
        let fadeAction = SKAction.fadeOut(withDuration: 0.5)
        let group = SKAction.group([moveAction, fadeAction])
        wind.run(SKAction.sequence([group, SKAction.removeFromParent()]))
    }
    
    func checkAndMoveHorse(direction: (dx: Int, dy: Int, name: String)) {
        var currentX = knightPosition.x + direction.dx
        var currentY = knightPosition.y + direction.dy
        
        // Find first horse in this direction
        var horsesToMove = [(x: Int, y: Int)]()
        
        while grid.indices.contains(currentY) && grid[currentY].indices.contains(currentX) {
            if grid[currentY][currentX] == 3 { // Horse found
                horsesToMove.append((x: currentX, y: currentY))
                
                //                moveHorseToEdge(horseX: currentX, horseY: currentY, direction: direction)
                //                return
            }
            currentX += direction.dx
            currentY += direction.dy
        }
        for horse in horsesToMove {
            moveHorseToEdge(horseX: horse.x, horseY: horse.y, direction: direction)
        }
        
        
    }
    
    func moveHorseToEdge(horseX: Int, horseY: Int, direction: (dx: Int, dy: Int, name: String)) {
        var newX = horseX
        var newY = horseY
        var path = [(x: Int, y: Int)]()
        
        while true {
            let nextX = newX + direction.dx
            let nextY = newY + direction.dy
            
            if grid.indices.contains(nextY) && grid[nextY].indices.contains(nextX) {
                if grid[nextY][nextX] == 1 {
                    path.append((x: nextX, y: nextY))
                    newX = nextX
                    newY = nextY
                    continue
                } else if grid[nextY][nextX] == 5 {
                    path.append((x: nextX, y: nextY))
                    break
                }
            }
            break
        }
        
        if path.isEmpty { return }
        
        grid[horseY][horseX] = 1
        
        guard let horseNode = childNode(withName: "horse_\(horseX)_\(horseY)") as? SKSpriteNode else { return }
        
        var actions = [SKAction]()
        
        for position in path {
            let destination = getVisualPosition(gridX: position.x, gridY: position.y)
            actions.append(SKAction.move(to: destination, duration: 0.2))
            
            if grid.indices.contains(position.y) && grid[position.y].indices.contains(position.x) && grid[position.y][position.x] == 5 {
                actions.append(SKAction.fadeOut(withDuration: 0.2))
                actions.append(SKAction.removeFromParent())
            }
        }
        
        let finalPosition = path.last!
        if grid.indices.contains(finalPosition.y) && grid[finalPosition.y].indices.contains(finalPosition.x) {
            if grid[finalPosition.y][finalPosition.x] != 5 {
                grid[finalPosition.y][finalPosition.x] = 3
                horseNode.name = "horse_\(finalPosition.x)_\(finalPosition.y)"
            }
        }
        
        horseNode.run(SKAction.sequence(actions)) {
            self.checkWin()
        }
    }
    
    func getVisualPosition(gridX: Int, gridY: Int) -> CGPoint {
        guard !grid.isEmpty else { return .zero }
        
        let numCols = grid[0].count
        let numRows = grid.count
        
        // Рассчитываем общий размер сетки с текущим tileSize
        let gridWidth = CGFloat(numCols) * tileSize
        let gridHeight = CGFloat(numRows) * rowSpacing
        
        // Рассчитываем максимально возможный размер, который помещается на экране
        let maxGridWidth = size.width * 0.9
        let maxGridHeight = size.height * 0.7
        
        // Определяем, нужно ли масштабирование
        var scale: CGFloat = 1.0
        if gridWidth > maxGridWidth || gridHeight > maxGridHeight {
            let widthScale = maxGridWidth / gridWidth
            let heightScale = maxGridHeight / gridHeight
            scale = min(widthScale, heightScale)
        }
        
        // Применяем масштабирование
        let scaledTileSize = tileSize * scale
        let scaledRowSpacing = rowSpacing * scale
        let scaledEntityYOffset = entityYOffset * scale
        
        // Центрируем игровое поле с учетом масштаба
        let scaledGridWidth = CGFloat(numCols) * scaledTileSize
        let scaledGridHeight = CGFloat(numRows) * scaledRowSpacing
        
        let startX = -scaledGridWidth / 2 + scaledTileSize / 2
        let startY = -scaledGridHeight / 2 + 100 * scale // Масштабируем отступ для header
        
        return CGPoint(
            x: startX + CGFloat(gridX) * scaledTileSize,
            y: startY + CGFloat(gridY) * scaledRowSpacing + scaledEntityYOffset
        )
    }
    
    func checkWin() {
        for r in 0..<grid.count {
            for c in 0..<grid[r].count {
                if grid[r][c] == 3 { return } // Horse still on field
            }
        }
        
        // Разблокируем следующий уровень только если это необходимо
        gameViewModel?.unlockNextLevel()
        
        // Show level complete modal
        showLevelCompleteModal()
    }
}
