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
