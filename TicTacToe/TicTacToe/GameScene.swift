//
//  GameScene.swift
//  TicTacToe
//
//  Created by Janie Clayton on 1/9/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Properties
    var board:[TileState] = []
    var currentPlayer:GameState = .notPlaying
    
    // Function Overrides
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        board = resetBoard()
        currentPlayer = switchPlayer(currentPlayer: currentPlayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Reset Board
func resetBoard() -> [TileState] {
    var board = [TileState]()
    
    for _ in 0...8 {
        let tile = TileState.notSelected
        board.append(tile)
    }
    
    return board
}

// Switch Player
func switchPlayer(currentPlayer: GameState) -> GameState {
    switch currentPlayer {
    case .playerA:
        return GameState.playerB
    case .playerB:
        return GameState.playerA
    case .notPlaying:
        return GameState.playerA
    }
}

// Make Move
func makeMove(tile: Int, currentPlayer: GameState, board: [TileState]) -> [TileState] {
    var newBoard = board
    
    switch currentPlayer {
    case .playerA:
        newBoard[tile] = .playerA
    case .playerB:
        newBoard[tile] = .playerB
    case .notPlaying:
        newBoard[tile] = .notSelected
    }
    
    return newBoard
}
