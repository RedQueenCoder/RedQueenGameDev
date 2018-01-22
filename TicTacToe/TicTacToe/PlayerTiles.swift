//
//  PlayerTiles.swift
//  TicTacToe
//
//  Created by Vic Metcalfe on 2018-01-22.
//

import Foundation

public struct PlayerTiles: OptionSet {
    public let rawValue: Int
    private var player: GameState?
    
    static let tile0 = PlayerTiles(rawValue: 1 << 0)
    static let tile1 = PlayerTiles(rawValue: 1 << 1)
    static let tile2 = PlayerTiles(rawValue: 1 << 2)
    static let tile3 = PlayerTiles(rawValue: 1 << 3)
    static let tile4 = PlayerTiles(rawValue: 1 << 4)
    static let tile5 = PlayerTiles(rawValue: 1 << 5)
    static let tile6 = PlayerTiles(rawValue: 1 << 6)
    static let tile7 = PlayerTiles(rawValue: 1 << 7)
    static let tile8 = PlayerTiles(rawValue: 1 << 8)
    static let tiles: [PlayerTiles] = [
        .tile0, .tile1, .tile2,
        .tile3, .tile4, .tile5,
        .tile6, .tile7, .tile8
    ]
    
    static let win_horizontal_top: PlayerTiles =    [.tile0, .tile1, .tile2]
    static let win_horizontal_middle: PlayerTiles = [.tile3, .tile4, .tile5]
    static let win_horizontal_bottom: PlayerTiles = [.tile6, .tile7, .tile8]
    static let win_vertical_left: PlayerTiles =     [.tile0, .tile3, .tile6]
    static let win_vertical_middle: PlayerTiles =   [.tile1, .tile4, .tile7]
    static let win_vertical_right: PlayerTiles =    [.tile2, .tile5, .tile8]
    static let win_slash: PlayerTiles =             [.tile2, .tile4, .tile6]
    static let win_backslash: PlayerTiles =         [.tile0, .tile4, .tile8]
    
    static let wins: [PlayerTiles] = [
        .win_horizontal_top, .win_horizontal_middle, .win_horizontal_bottom,
        .win_vertical_left, .win_vertical_middle, .win_vertical_right,
        .win_slash, .win_backslash
    ]

    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.player = nil
    }

    public static func from(player: GameState, board: [TileState]) -> PlayerTiles {
        let requiredState:TileState = player == .playerA ? .playerA : .playerB
        var playerTiles = PlayerTiles(rawValue: 0)
        for (index, tile) in board.enumerated() {
            if (tile == requiredState) {
                playerTiles = playerTiles.union(PlayerTiles.tiles[index])
            }
        }
        playerTiles.player = player
        return playerTiles
    }
    
    public func isWin() -> GameEndState {
        for win in PlayerTiles.wins {
            if self.contains(win) {
                return player == .playerA ? .playerAWin : .playerBWin
            }
        }
        
        return .draw
    }
}
