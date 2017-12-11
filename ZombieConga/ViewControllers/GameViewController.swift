//
//  GameViewController.swift
//  ZombieConga
//
//  Created by Quoc Nguyen on 12/11/17.
//  Copyright © 2017 Quoc Nguyen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: CGSize(width: 2048, height: 1536))
        scene.scaleMode = .aspectFill
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
