//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Janie Clayton on 1/21/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import XCTest
@testable import TicTacToe

class TicTacToeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWins() {
        let win_top:[TileState] = [
            .playerA,       .playerA,       .playerA,
            .notSelected,   .playerB,       .notSelected,
            .playerB,       .notSelected,   .notSelected
        ]
        let tiles = PlayerTiles.from(player: .playerA, board: win_top)
        XCTAssertEqual(tiles.isWin(), GameEndState.playerAWin)
    }
}
