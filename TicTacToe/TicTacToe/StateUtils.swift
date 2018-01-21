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
