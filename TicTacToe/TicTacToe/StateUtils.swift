//
//  StateUtils.swift
//  TicTacToe
//
//  Created by Janie Clayton on 1/9/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import Foundation

enum GameState: String {
    case notPlaying
    case playerA = "Player A"
    case playerB = "Player B"
}


//enum TileState {
//    case notSelected
//    case playerA
//    case playerB
//}


enum TileState: Equatable {
    case notSelected
    case playerA(swap:Int)
    case playerB(swap:Int)
    
    func swap() -> Int {
        switch (self) {
        case .notSelected: return 0
        case let .playerA(currentSwap): return currentSwap
        case let .playerB(currentSwap): return currentSwap
        }
    }
    
    static public func == (lhs: TileState, rhs: TileState) -> Bool {
        switch (lhs, rhs) {
        case (.playerA, .playerA):
            return true
        case (.playerB, .playerB):
            return true
        case (.notSelected, .notSelected):
            return true
        default:
            return false
        }
    }
}

enum GameEndState: String {
    case playerAWin = "Player A Wins!"
    case playerBWin = "Player B Wins!"
    case draw = "Draw!"
}

enum GameVariation {
    case normal
    case reversed
    case swap
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
        newBoard[tile] = .playerA(swap:board[tile].swap() + 1)
    case .playerB:
        newBoard[tile] = .playerB(swap:board[tile].swap() + 1)
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
        requiredState = .playerA(swap: 1)
        gameEnd = .playerAWin
    } else if currentPlayer == .playerB {
        requiredState = .playerB(swap: 1)
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

// Game AI functions
func moveState(currentPlayer: GameState, currentBoard: [TileState], move: Int) -> Int {
    var moveValue: Int
    
    let newState = makeMove(tile: move, currentPlayer: currentPlayer, board: currentBoard) // This doesn't set the new board even though it should
    guard let isWin = checkForWin(currentPlayer: currentPlayer, board: newState) else {return 0}
    
    switch isWin {
    case .playerAWin:
        moveValue = -1 // This never executes because newState doesn't update the board by making a move
    case .playerBWin:
        moveValue = 1
    case .draw:
        moveValue = 0
    }
    
    return moveValue
}

func possibleMoveValues(currentPlayer: GameState, currentBoard: [TileState]) -> [Int:Int] {
    var moveValueTable = [Int:Int]()
    
    for (index, tile) in currentBoard.enumerated() {
        if tile == .notSelected {
            let moveValue = moveState(currentPlayer: currentPlayer, currentBoard: currentBoard, move: index)
            moveValueTable[index] = moveValue
        }
    }
    
    return moveValueTable
}

func makeAIMove(currentPlayer: GameState, board: [TileState]) -> (board: [TileState], move: Int) {
    var newBoard = board
    var move:Int
    
    let possibleImmediateWinValues = possibleMoveValues(currentPlayer: .playerB, currentBoard: board)
    let possibleImmediateLossValues = possibleMoveValues(currentPlayer: .playerA, currentBoard: board)
    
    if let immediateWin = possibleImmediateWinValues.filter({$1 == 1}).first {
        move = immediateWin.key
    } else if let immediateLoss = possibleImmediateLossValues.filter({$1 == -1}).first {
        move = immediateLoss.key
    } else {
        let possibleMoves = Array(possibleImmediateWinValues.keys)
        move = possibleMoves[Int(arc4random_uniform(UInt32(possibleMoves.count)))]
    }
    
    newBoard = makeMove(tile: move, currentPlayer: currentPlayer, board: board)

    return (newBoard, move)
}
