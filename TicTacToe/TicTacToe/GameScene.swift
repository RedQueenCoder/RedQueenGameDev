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
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
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
                sprite.color = UIColor.red
                sprite.size = CGSize(width: tileSize, height: tileSize)
                sprite.name = "Tile\(tileCounter)"
                
                let xPosition = CGFloat(outerBorderPadding) + CGFloat(xIndex) * (tileSize + betweenTilesPadding)
                let yPosition = CGFloat(outerBorderPadding) + CGFloat(2 - yIndex) * (tileSize + betweenTilesPadding)

                sprite.anchorPoint = CGPoint.zero
                sprite.position = CGPoint(x: xPosition, y: yPosition)
                boardLayer.addChild(sprite)

                tileCounter += 1
            }
        }
        
        //        board = resetBoard()
        //        currentPlayer = switchPlayer(currentPlayer: currentPlayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


