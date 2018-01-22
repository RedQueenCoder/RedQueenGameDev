//
//  StateUtils.swift
//  TicTacToe
//
//  Created by Janie Clayton on 1/9/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import Foundation

public enum GameState {
    case notPlaying
    case playerA
    case playerB
}

public enum TileState {
    case notSelected
    case playerA
    case playerB
}

public enum GameEndState {
    case playerAWin
    case playerBWin
    case draw
}
