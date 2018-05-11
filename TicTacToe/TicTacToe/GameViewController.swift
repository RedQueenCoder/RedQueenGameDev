//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Janie Clayton on 1/9/18.
//  Copyright © 2018 Janie Clayton. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: MainMenuScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        if let scene = SKScene(fileNamed: "MainMenuScene") {
            skView.presentScene(scene)
        }
            
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
