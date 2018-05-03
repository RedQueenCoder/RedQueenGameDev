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
        let nodeSize = node.size
        let largeNodeSize = CGSize(width: nodeSize.width + 30, height: nodeSize.height + 30)
        let spritePosition = CGPoint(x: node.size.width / 2, y: node.size.height / 2)
        
        // Actions
        let fadeAction = SKAction.fadeIn(withDuration: 0.75)
        let scaleUpAction = SKAction.scale(to: largeNodeSize, duration: 0.5)
        let scaleDownAction = SKAction.scale(to: nodeSize, duration: 0.25)
        let soundEffect = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let pauseAction = SKAction.wait(forDuration: 2.0)
        let scaleSequence = SKAction.sequence([scaleUpAction, soundEffect, scaleDownAction])
        let actionGroup = SKAction.group([fadeAction, scaleSequence])
        let aiActionGroup = SKAction.sequence([pauseAction, actionGroup])
        
        if board[tiles.index(of: node)!] == .notSelected {
            isUserInteractionEnabled = false
            
            // Human player's turn
            let playerTile = SKSpriteNode(imageNamed: "pastry_donut_320")
            playerTile.setScale(0)
            playerTile.position = spritePosition
            node.addChild(playerTile)
            playerTile.run(actionGroup)
            board[tiles.index(of: node)!] = .playerA
            
            // Check for Human Player Win
            if let isWin = checkForWin(currentPlayer: currentPlayer, board: board) {
                label.text = isWin.rawValue
                return
            } else {
                currentPlayer = switchPlayer(currentPlayer: currentPlayer)
                label.text = "\(currentPlayer.rawValue)'s Turn"
            }
            
            // AI's turn
            let aimove = makeAIMove(currentPlayer: currentPlayer, board: board)
            board = aimove.board
            let aiTile = SKSpriteNode(imageNamed: "pastry_starcookie02_320")
            aiTile.setScale(0)
            aiTile.position = spritePosition
            tiles[aimove.move].addChild(aiTile)
            aiTile.run(aiActionGroup)
            
            if let isWin = checkForWin(currentPlayer: currentPlayer, board: board) {
                label.text = isWin.rawValue
            } else {
                currentPlayer = switchPlayer(currentPlayer: currentPlayer)
                label.text = "\(currentPlayer.rawValue)'s Turn"
                isUserInteractionEnabled = true
            }
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
                sprite.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
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
        
        run(SKAction.playSoundFileNamed("Carpe Diem.mp3", waitForCompletion: false))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


