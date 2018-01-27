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
    
    // Properties
    var board:[TileState] = []
    var currentPlayer:GameState = .notPlaying
    
    // Function Overrides
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        board = resetBoard()
        currentPlayer = switchPlayer(currentPlayer: currentPlayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


