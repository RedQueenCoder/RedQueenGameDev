//
//  MainMenuScene.swift
//  TicTacToe
//
//  Created by Janie Clayton-Hasz on 5/4/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {

    }
    
    func sceneTapped() {
        let myScene = GameScene(size: size, variation: .normal)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.doorway(withDuration: 1.5)
        view?.presentScene(myScene, transition: reveal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        sceneTapped()
    }
    
}
