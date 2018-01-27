//
//  StateUtils.swift
//  TicTacToe
//
//  Created by Janie Clayton on 1/9/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import Foundation

enum GameState {
    case notPlaying
    case playerA
    case playerB
}

enum TileState {
    case notSelected
    case playerA
    case playerB
}

enum GameEndState {
    case playerAWin
    case playerBWin
    case draw
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

// Check for Win
func checkForWin(currentPlayer: GameState, board: [TileState]) -> GameEndState? {
    var requiredState:TileState
    var gameEnd:GameEndState
    
    if currentPlayer == .playerA {
        requiredState = .playerA
        gameEnd = .playerAWin
    } else if currentPlayer == .playerB {
        requiredState = .playerB
        gameEnd = .playerBWin
    } else {
        return nil
    }
    
    // Three across the top
    if board[0] == requiredState && board[1] == requiredState && board[2] == requiredState {
        return gameEnd
    }
    
    // Three across the middle
    if board[3] == requiredState && board[4] == requiredState && board[5] == requiredState {
        return gameEnd
    }
    
    // Three across the bottom
    if board[6] == requiredState && board[7] == requiredState && board[8] == requiredState {
        return gameEnd
    }
    
    // Three down the left
    if board[0] == requiredState && board[3] == requiredState && board[6] == requiredState {
        return gameEnd
    }
    
    // Three down the middle
    if board[1] == requiredState && board[4] == requiredState && board[7] == requiredState {
        return gameEnd
    }
    
    // Three down the right
    if board[2] == requiredState && board[5] == requiredState && board[8] == requiredState {
        return gameEnd
    }
    
    // Three diagonally from the upper left
    if board[0] == requiredState && board[4] == requiredState && board[8] == requiredState {
        return gameEnd
    }
    
    // Three diagonally from the upper right
    if board[2] == requiredState && board[4] == requiredState && board[6] == requiredState {
        return gameEnd
    }
    
    // Draw
    for tile in board {
        if tile == .notSelected {
            return nil
        }
    }
    
    gameEnd = .draw
    return gameEnd
}
