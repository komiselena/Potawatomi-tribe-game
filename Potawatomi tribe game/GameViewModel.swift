//
//  GameViewModel.swift
//  Potawatomi tribe game
//
//  Created by Mac on 13.05.2025.
//

import Foundation


class GameViewModel: ObservableObject {
    @Published var backgroundImage: String = "BG1"
    @Published var skin: String = "skin1"
    @Published var currentLevel: Int = 1
    @Published var unlockedLevels: Int = 1
    
    func unlockNextLevel() {
        // Разблокируем следующий уровень только если текущий уровень равен последнему разблокированному
        if currentLevel == unlockedLevels {
            unlockedLevels = currentLevel + 1
        }
        
        // Проверяем достижения
        if currentLevel == 2 {
            completedFirstLevel = true
        } else if currentLevel == 6 {
            completed5Levels = true
        } else if currentLevel == 8 {
            completed7Levels = true
        } else if currentLevel == 10 {
            completedAllLevels = true
        }
    }
    
    @Published var completedFirstLevel: Bool = false
    @Published var completed5Levels: Bool = false
    @Published var completed7Levels: Bool = false
    @Published var accumulated1000hourseshoes: Bool = false
    @Published var completedAllLevels: Bool = false

    
    @Published var hideCompletedFirstLevel = false
    @Published var hideCompleted5Levels = false
    @Published var hideCompleted7Levels = false
    @Published var hideCompletedAllLevels = false
    @Published var hideAccumulated = false

}
