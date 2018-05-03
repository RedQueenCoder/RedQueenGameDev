//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Janie Clayton on 1/21/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import XCTest

class TicTacToeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testResetBoard() {
        let accurateBoard:[TileState] = [TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected,
                                         TileState.notSelected]
        
        let testBoard = resetBoard()
        
        XCTAssertEqual(accurateBoard, testBoard)
    }
    
    func testSwitchPlayer() {
        // Player Objects
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        // Player A Case
        let firstPlayerTest = switchPlayer(currentPlayer: playerA)
        XCTAssertEqual(firstPlayerTest, playerB)
        
        // Player B Case
        let secondPlayerTest = switchPlayer(currentPlayer: playerB)
        XCTAssertEqual(secondPlayerTest, playerA)
        
        // Not Currently Playing Case
        let thirdPlayerTest = switchPlayer(currentPlayer: GameState.notPlaying)
        XCTAssertEqual(thirdPlayerTest, playerA)
    }
    
    func testMakeMove() {
        // Objects
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        let notPlaying = GameState.notPlaying
        
        let selectedA = TileState.playerA
        let selectedB = TileState.playerB
        
        let blankBoard = resetBoard()
        
        // Player A move
        let firstNewBoard = makeMove(tile: 0, currentPlayer: playerA, board: blankBoard)
        XCTAssertNotEqual(blankBoard, firstNewBoard)
        XCTAssertEqual(firstNewBoard[0], TileState.playerA)
        XCTAssertEqual(firstNewBoard[5], blankBoard[5])
        
        // Player B move
        let secondNewBoard = makeMove(tile: 2, currentPlayer: playerB, board: blankBoard)
        XCTAssertNotEqual(blankBoard, secondNewBoard)
        XCTAssertEqual(secondNewBoard[2], TileState.playerB)
        XCTAssertEqual(secondNewBoard[8], blankBoard[8])
        
        // Moves by both Player A and Player B
        let firstMove = makeMove(tile: 4, currentPlayer: playerA, board: blankBoard)
        let secondMove = makeMove(tile: 0, currentPlayer: playerB, board: firstMove)
        let thirdMove = makeMove(tile: 2, currentPlayer: playerA, board: secondMove)
        
        XCTAssertNotEqual(firstMove, blankBoard)
        XCTAssertNotEqual(secondMove, firstMove)
        XCTAssertNotEqual(thirdMove, secondMove)
        
        XCTAssertEqual(thirdMove[4], selectedA)
        XCTAssertEqual(thirdMove[0], selectedB)
        XCTAssertEqual(thirdMove[2], selectedA)
        
        // Not Playing move
        let notSelectedBoard = makeMove(tile: 5, currentPlayer: notPlaying, board: blankBoard)
        XCTAssertEqual(notSelectedBoard, blankBoard)
    }
    
    func testHorizontalWin() {
        // Objects
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        let playerAWin = GameEndState.playerAWin
        let playerBWin = GameEndState.playerBWin
        
        let blankBoard = resetBoard()
        
        // Check across the top win
        let top1 = makeMove(tile: 0, currentPlayer: playerA, board: blankBoard)
        let top2 = makeMove(tile: 1, currentPlayer: playerA, board: top1)
        let top3 = makeMove(tile: 2, currentPlayer: playerA, board: top2)
        
        let checkForTopWin = checkForWin(currentPlayer: playerA, board: top3)
        let notAWinYetTop = checkForWin(currentPlayer: playerA, board: top2)
        let wrongPlayerTop = checkForWin(currentPlayer: playerB, board: top3)
        
        XCTAssertEqual(checkForTopWin, playerAWin)
        XCTAssertNil(notAWinYetTop)
        XCTAssertNil(wrongPlayerTop)
        
        // Check across the middle win
        let middle1 = makeMove(tile: 3, currentPlayer: playerB, board: blankBoard)
        let middle2 = makeMove(tile: 4, currentPlayer: playerB, board: middle1)
        let middle3 = makeMove(tile: 5, currentPlayer: playerB, board: middle2)
        
        let checkForMiddleWin = checkForWin(currentPlayer: playerB, board: middle3)
        let notAWinYetMiddle = checkForWin(currentPlayer: playerB, board: middle1)
        let wrongPlayerMiddle = checkForWin(currentPlayer: playerA, board: middle3)
        
        XCTAssertEqual(checkForMiddleWin, playerBWin)
        XCTAssertNil(notAWinYetMiddle)
        XCTAssertNil(wrongPlayerMiddle)
        
        // Check across the bottom win
        let bottom1 = makeMove(tile: 6, currentPlayer: playerA, board: blankBoard)
        let bottom2 = makeMove(tile: 7, currentPlayer: playerA, board: bottom1)
        let bottom3 = makeMove(tile: 8, currentPlayer: playerA, board: bottom2)
        
        let checkForBottomWin = checkForWin(currentPlayer: playerA, board: bottom3)
        let notAWinYetBottom = checkForWin(currentPlayer: playerA, board: bottom2)
        let wrongPlayerBottom = checkForWin(currentPlayer: playerB, board: bottom3)
        
        XCTAssertEqual(checkForBottomWin, playerAWin)
        XCTAssertNil(notAWinYetBottom)
        XCTAssertNil(wrongPlayerBottom)
    }
    
    func testVerticalWin() {
        // Objects
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        let playerAWin = GameEndState.playerAWin
        let playerBWin = GameEndState.playerBWin
        
        let blankBoard = resetBoard()
        
        // Check down the left
        let left1 = makeMove(tile: 0, currentPlayer: playerB, board: blankBoard)
        let left2 = makeMove(tile: 3, currentPlayer: playerB, board: left1)
        let left3 = makeMove(tile: 6, currentPlayer: playerB, board: left2)
        
        let checkForLeftWin = checkForWin(currentPlayer: playerB, board: left3)
        let notAWinYetLeft = checkForWin(currentPlayer: playerB, board: left1)
        let wrongPlayerLeft = checkForWin(currentPlayer: playerA, board: left3)
        
        XCTAssertEqual(checkForLeftWin, playerBWin)
        XCTAssertNil(notAWinYetLeft)
        XCTAssertNil(wrongPlayerLeft)
        
        // Check down the middle
        let middle1 = makeMove(tile: 1, currentPlayer: playerA, board: blankBoard)
        let middle2 = makeMove(tile: 4, currentPlayer: playerA, board: middle1)
        let middle3 = makeMove(tile: 7, currentPlayer: playerA, board: middle2)
        
        let checkForMiddleWin = checkForWin(currentPlayer: playerA, board: middle3)
        let notAWinYetMiddle = checkForWin(currentPlayer: playerA, board: middle2)
        let wrongPlayerMiddle = checkForWin(currentPlayer: playerB, board: middle3)
        
        XCTAssertEqual(checkForMiddleWin, playerAWin)
        XCTAssertNil(notAWinYetMiddle)
        XCTAssertNil(wrongPlayerMiddle)
        
        // Check down the right
        let right1 = makeMove(tile: 2, currentPlayer: playerB, board: blankBoard)
        let right2 = makeMove(tile: 5, currentPlayer: playerB, board: right1)
        let right3 = makeMove(tile: 8, currentPlayer: playerB, board: right2)
        
        let checkForRightWin = checkForWin(currentPlayer: playerB, board: right3)
        let notAWinYetRight = checkForWin(currentPlayer: playerB, board: right2)
        let wrongPlayerRight = checkForWin(currentPlayer: playerA, board: right3)
        
        XCTAssertEqual(checkForRightWin, playerBWin)
        XCTAssertNil(notAWinYetRight)
        XCTAssertNil(wrongPlayerRight)
        
    }
    
    func testDiagonalWin() {
        // Objects
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        let playerAWin = GameEndState.playerAWin
        let playerBWin = GameEndState.playerBWin
        
        let blankBoard = resetBoard()
        
        // Check upper left win
        let upperLeft1 = makeMove(tile: 0, currentPlayer: playerA, board: blankBoard)
        let upperLeft2 = makeMove(tile: 4, currentPlayer: playerA, board: upperLeft1)
        let upperLeft3 = makeMove(tile: 8, currentPlayer: playerA, board: upperLeft2)
        
        let checkForUpperLeftWin = checkForWin(currentPlayer: playerA, board: upperLeft3)
        let notAWinYetUpperLeft = checkForWin(currentPlayer: playerA, board: upperLeft2)
        let wrongPlayerUpperLeft = checkForWin(currentPlayer: playerB, board: upperLeft3)
        
        XCTAssertEqual(checkForUpperLeftWin, playerAWin)
        XCTAssertNil(notAWinYetUpperLeft)
        XCTAssertNil(wrongPlayerUpperLeft)
        
        // Check upper right win
        let upperRight1 = makeMove(tile: 2, currentPlayer: playerB, board: blankBoard)
        let upperRight2 = makeMove(tile: 4, currentPlayer: playerB, board: upperRight1)
        let upperRight3 = makeMove(tile: 6, currentPlayer: playerB, board: upperRight2)
        
        let checkForUpperRightWin = checkForWin(currentPlayer: playerB, board: upperRight3)
        let notAWinYetUpperRight = checkForWin(currentPlayer: playerB, board: upperRight1)
        let wrongPlayerUpperRight = checkForWin(currentPlayer: playerA, board: upperRight3)
        
        XCTAssertEqual(checkForUpperRightWin, playerBWin)
        XCTAssertNil(notAWinYetUpperRight)
        XCTAssertNil(wrongPlayerUpperRight)
    }
    
    func testDraw() {
        // Objects
        let playerA = GameState.playerA
        let draw = GameEndState.draw
        
        let selectedA = TileState.playerA
        let selectedB = TileState.playerB
        let notSelected = TileState.notSelected
        
        // Boards
        let drawBoard:[TileState] = [selectedA, selectedA, selectedB,
                                 selectedB, selectedA, selectedB,
                                 selectedA, selectedB, selectedB]
        let blankBoard = resetBoard()
        let nonBlankBoard:[TileState] = [notSelected, notSelected, notSelected,
                                         notSelected, selectedA, notSelected,
                                         notSelected, notSelected, notSelected]
        
        // Test variables and assertions
        let drawCondition = checkForWin(currentPlayer: playerA, board: drawBoard)
        let startGame = checkForWin(currentPlayer: playerA, board: blankBoard)
        let firstMove = checkForWin(currentPlayer: playerA, board: nonBlankBoard)
        
        XCTAssertEqual(drawCondition, draw)
        XCTAssertNil(startGame)
        XCTAssertNil(firstMove)
    }
    
    // AI Tests
    func testMoveState() {
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        let selectedA = TileState.playerA
        let selectedB = TileState.playerB
        let notSelected = TileState.notSelected
        
        let playerAWinBoard:[TileState] = [selectedA, selectedA, notSelected,
                                           notSelected, selectedB, notSelected,
                                           notSelected, notSelected, notSelected]
        
        let playerAWinState = moveState(currentPlayer: playerA, currentBoard: playerAWinBoard, move: 2)
        XCTAssertEqual(playerAWinState, -1)
        
        let playerBWinBoard:[TileState] = [notSelected, notSelected, notSelected,
                                           notSelected, selectedB, notSelected,
                                           selectedB, selectedA, selectedA]
        
        let playerBWinState = moveState(currentPlayer: playerB, currentBoard: playerBWinBoard, move: 2)
        XCTAssertEqual(playerBWinState, 1)
        
        let neitherWinNorLoseBoard:[TileState] = [notSelected, notSelected, notSelected,
                                                  notSelected, notSelected, notSelected,
                                                  notSelected, notSelected, notSelected]
        
        let newBoardState = moveState(currentPlayer: playerA, currentBoard: neitherWinNorLoseBoard, move: 4)
        XCTAssertEqual(newBoardState, 0)
    }
    
    /*
    func testMoveValues() {
        let playerA = GameState.playerA
        let playerB = GameState.playerB
        
        let selectedA = TileState.playerA
        let selectedB = TileState.playerB
        let notSelected = TileState.notSelected
     
        let playerAWinBoard:[TileState] = [selectedA, selectedA, notSelected,
                                           notSelected, selectedB, notSelected,
                                           notSelected, notSelected, notSelected]
        
        let playerAWinDictionary = possibleMoveValues(currentPlayer: playerA, currentBoard: playerAWinBoard)
        let playerBLoseDictionary = possibleMoveValues(currentPlayer: playerB, currentBoard: playerAWinBoard)
        
        XCTAssertEqual(playerAWinDictionary.count, 6)
        XCTAssertEqual(playerBLoseDictionary.count, 6)
        
        XCTAssertEqual(playerAWinDictionary[2], -1) // This should be -1 but it is coming back 0
        XCTAssertEqual(playerAWinDictionary[3], 0)
        XCTAssertEqual(playerAWinDictionary[5], 0)
        XCTAssertEqual(playerAWinDictionary[6], 0)
        XCTAssertEqual(playerAWinDictionary[7], 0)
        XCTAssertEqual(playerAWinDictionary[8], 0)
        
        let playerAWinBoard:[TileState] = [selectedA, selectedA, notSelected,
                                           selectedB, selectedB, selectedA,
                                           selectedB, selectedB, selectedA]
        
        let playerAWinDictionary = possibleMoveValues(currentPlayer: playerA, currentBoard: playerAWinBoard)
        XCTAssertEqual(playerAWinDictionary.count, 1)
        XCTAssertEqual(playerAWinDictionary[2], -1)
    }
    */
    
}

/*
 func possibleMoveValues(currentPlayer: GameState, currentBoard: [TileState]) -> [Int:Int] {
 var moveValueTable = [Int:Int]()
 
 for (index, tile) in currentBoard.enumerated() {
 if tile == .notSelected {
 let moveValue = moveState(currentPlayer: currentPlayer, currentBoard: currentBoard, move: tile.hashValue)
 moveValueTable[index] = moveValue
 }
 }
 
 return moveValueTable
 }
*/
