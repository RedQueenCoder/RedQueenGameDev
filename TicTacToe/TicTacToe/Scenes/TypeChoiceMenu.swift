//
//  TypeChoiceMenu.swift
//  TicTacToe
//
//  Created by Janie Clayton-Hasz on 5/3/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import SpriteKit
import GameplayKit

class TypeChoiceMenu: SKScene {
    override func didMove(to view: SKView) {

    }
    
    // Check for node type and pass into the initializer
    func sceneTapped(_ type: GameVariation) {
        // Update GameScene init for game type
        let myScene = GameScene(size: size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.doorway(withDuration: 1.5)
        view?.presentScene(myScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        let rawNodes = nodes(at: location)
        let tappedNodes = rawNodes.filter{return $0.name != nil}
        
        guard let node = tappedNodes.first as? SKSpriteNode else {return}
        
        switch node.name {
        case "RegularButton":
            sceneTapped(.normal)
        case "ReverseButton":
            sceneTapped(.reversed)
        case "TileSwap":
            sceneTapped(.swap)
        default:
            break
        }
    }
}
