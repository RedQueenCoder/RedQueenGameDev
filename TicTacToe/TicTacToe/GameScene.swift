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
    
    // Model Properties
    var board:[TileState] = []
    var currentPlayer:GameState = .notPlaying
    
    // View Properties
    let boardLayer = SKSpriteNode()
    var tiles:[SKSpriteNode] = []
    let outerBorderPadding:CGFloat = 30.0
    let betweenTilesPadding:CGFloat = 15.0

    // Function Overrides
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let rawNodes = nodes(at: location)
        let tappedNodes = rawNodes.filter{return $0.name != nil}
        
        guard let node = tappedNodes.first as? SKSpriteNode else {return}
        
        if board[tiles.index(of: node)!] == .notSelected {
            switch currentPlayer {
            case .playerA:
                node.color = UIColor.black
                board[tiles.index(of: node)!] = .playerA
            case .playerB:
                node.color = UIColor.red
                board[tiles.index(of: node)!] = .playerB
            case .notPlaying:
                node.color = UIColor.white
                board[tiles.index(of: node)!] = .notSelected
            }
        }
        
        if let isWin = checkForWin(currentPlayer: currentPlayer, board: board) {
            switch isWin {
            case .playerAWin:
                print("Player A wins")
            case .playerBWin:
                print("Player B wins")
            case .draw:
                print("No one wins. Everyone gets a participation trophy")
            }
        }
        
        currentPlayer = switchPlayer(currentPlayer: currentPlayer)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(color: UIColor.white, size: size)
        addChild(background)

        let boardSize = size.width
        boardLayer.anchorPoint = CGPoint.zero
        boardLayer.position = CGPoint(x: -(boardSize / 2.0), y: -(boardSize / 2.0))
        boardLayer.size = CGSize(width: boardSize, height: boardSize)
        boardLayer.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        addChild(boardLayer)
        
        let padding = (outerBorderPadding * 2) + (betweenTilesPadding * 2)
        let tileSize = (boardSize - CGFloat(padding)) / 3

        var tileCounter = 0
        for yIndex in 0..<3 {
            for xIndex in 0..<3 {
                let sprite = SKSpriteNode()
                sprite.color = UIColor.white
                sprite.size = CGSize(width: tileSize, height: tileSize)
                sprite.name = "Tile\(tileCounter)"
                
                let xPosition = CGFloat(outerBorderPadding) + CGFloat(xIndex) * (tileSize + betweenTilesPadding)
                let yPosition = CGFloat(outerBorderPadding) + CGFloat(2 - yIndex) * (tileSize + betweenTilesPadding)

                sprite.anchorPoint = CGPoint.zero
                sprite.position = CGPoint(x: xPosition, y: yPosition)
                boardLayer.addChild(sprite)
                tiles.append(sprite)

                tileCounter += 1
            }
        }
        
                board = resetBoard()
                currentPlayer = switchPlayer(currentPlayer: currentPlayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


