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
    let label = SKLabelNode(fontNamed: "Noteworthy-Bold")
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
                let playerTile = SKSpriteNode(imageNamed: "pastry_donut_320")
                playerTile.scale(to: node.size)
                playerTile.position = CGPoint(x: node.size.width / 2, y: node.size.height / 2)
                node.addChild(playerTile)
                board[tiles.index(of: node)!] = .playerA
            case .playerB:
                let playerTile = SKSpriteNode(imageNamed: "pastry_starcookie02_320")
                playerTile.scale(to: node.size)
                playerTile.position = CGPoint(x: node.size.width / 2, y: node.size.height / 2)
                node.addChild(playerTile)
                board[tiles.index(of: node)!] = .playerB
            case .notPlaying:
                node.color = UIColor.white
                board[tiles.index(of: node)!] = .notSelected
            }
        }
        
        if let isWin = checkForWin(currentPlayer: currentPlayer, board: board) {
            label.text = isWin.rawValue
            isUserInteractionEnabled = false
        } else {
            currentPlayer = switchPlayer(currentPlayer: currentPlayer)
            label.text = "\(currentPlayer.rawValue)'s Turn"
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        isUserInteractionEnabled = true
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "bg_ipad_portrait")
        background.zPosition = -1
        addChild(background)

        let boardSize = size.width
        boardLayer.anchorPoint = CGPoint.zero
        boardLayer.position = CGPoint(x: -(boardSize / 2.0), y: -(boardSize / 2.0))
        boardLayer.size = CGSize(width: boardSize, height: boardSize)
        boardLayer.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        addChild(boardLayer)
        
        let labelBackground = SKSpriteNode(imageNamed: "headerBacking")
        labelBackground.zPosition = 2
        labelBackground.size = CGSize(width: boardSize, height: 60.0)
        labelBackground.position = CGPoint(x: 0.0, y: (boardSize / 2.0) + 100)
        labelBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(labelBackground)
        
        label.fontColor = SKColor.black
        label.fontSize = 40
        label.zPosition = 10
        label.position = CGPoint(x: 0.0, y: -20.0)
        labelBackground.addChild(label)
        
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
        label.text = "\(currentPlayer.rawValue)'s Turn"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


