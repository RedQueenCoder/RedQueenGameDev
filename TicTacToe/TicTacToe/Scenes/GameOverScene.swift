//
//  GameOverScene.swift
//  TicTacToe
//
//  Created by Janie Clayton-Hasz on 5/4/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    let endState:GameEndState
    let background = SKSpriteNode(imageNamed: "bg_ipad_portrait")
    let label = SKLabelNode(fontNamed: "Noteworthy-Bold")
    var iconNode = SKSpriteNode()
    
    init(size: CGSize, endState: GameEndState) {
        self.endState = endState
        super.init(size: size)
        
        isUserInteractionEnabled = false
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        background.zPosition = -1
        addChild(background)
        
        let labelBackground = SKSpriteNode(imageNamed: "headerBacking")
        labelBackground.zPosition = 2
        labelBackground.size = CGSize(width: self.size.width, height: 60.0)
        labelBackground.position = CGPoint(x: 0.0, y: (self.size.width / 2.0) + 100)
        labelBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(labelBackground)
        
        label.fontColor = SKColor.black
        label.fontSize = 40
        label.zPosition = 10
        label.position = CGPoint(x: 0.0, y: -20.0)
        labelBackground.addChild(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        switch endState {
        case .playerAWin:
            iconNode = SKSpriteNode(imageNamed: "pastry_donut_320")
            label.text = "Player A Wins!"
        case .playerBWin:
            iconNode = SKSpriteNode(imageNamed: "pastry_starcookie02_320")
            label.text = "Player B Wins!"
        case .draw:
            // Do something different because it should be like both or something
            iconNode = SKSpriteNode(imageNamed: "pastry_starcookie02_320")
            label.text = "Draw"
        }
        
        let spritePosition = CGPoint(x: 0.0, y: 0.0)
        let spriteSize = CGSize(width: 320, height: 320)
        
        // Actions
        let fadeAction = SKAction.fadeIn(withDuration: 0.75)
        let scaleUpAction = SKAction.scale(to: CGSize(width: spriteSize.width * 1.5, height: spriteSize.height * 1.5), duration: 0.5)
        let scaleDownAction = SKAction.scale(to: spriteSize, duration: 0.25)
        let soundEffect = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let scaleSequence = SKAction.sequence([scaleUpAction, soundEffect, scaleDownAction])
        let actionGroup = SKAction.group([fadeAction, scaleSequence])
        
        iconNode.setScale(0)
        iconNode.position = spritePosition
        iconNode.zPosition = 10
        addChild(iconNode)
        iconNode.run(actionGroup)
        
        let wait = SKAction.wait(forDuration: 5.0)
        let block = SKAction.run {
            if let scene = SKScene(fileNamed: "MainMenuScene") {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                self.view?.presentScene(scene, transition: reveal)
            }
        }
        self.run(SKAction.sequence([wait, block]))
    }
    
}
