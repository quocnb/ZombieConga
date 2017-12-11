//
//  GameScene.swift
//  ZombieConga
//
//  Created by Quoc Nguyen on 12/11/17.
//  Copyright © 2017 Quoc Nguyen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    let zombie = SKSpriteNode(imageNamed: "zombie1")
    let zombieMovePointsPerSec: CGFloat = 480
    let zombieRotateRadiansPerSec: CGFloat = 4.0 * CGFloat.pi
    var velocity = CGPoint.zero

    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0

    let playableRect: CGRect

    // MARK: - Lifecycle
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin,
                              width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        // Background
        let background = SKSpriteNode(imageNamed: "background1")
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5) // default
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)

        // Add zombies
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
    }

    override func update(_ currentTime: TimeInterval) {
        dt = lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0
        lastUpdateTime = currentTime
        move(sprite: self.zombie, velocity: self.velocity)
        rotate(sprite: self.zombie, direction: self.velocity, rotateRadiansPerSec: zombieRotateRadiansPerSec)
        boundCheck()
    }

    // MARK: - Action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneTouched(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneTouched(touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    // MARK: - Process
    private func sceneTouched(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        moveZombieToward(location)
    }

    private func move(sprite: SKSpriteNode, velocity: CGPoint) {
        sprite.position += velocity * CGFloat(dt)
    }

    private func moveZombieToward(_ location: CGPoint) {
        let offset = location - self.zombie.position
        let unitVector = offset.normalized()
        self.velocity = unitVector * zombieMovePointsPerSec
    }

    private func boundCheck() {
        var zombieX = self.zombie.position.x
        var zombieY = self.zombie.position.y
        let minX = playableRect.minX, maxX = playableRect.maxX,
            minY = playableRect.minY, maxY = playableRect.maxY
        if zombieX < minX {
            zombieX = minX
            self.velocity.x = -self.velocity.x
        } else if zombieX > maxX {
            zombieX = maxX
            self.velocity.x = -self.velocity.x
        }
        if zombieY < minY {
            zombieY = minY
            self.velocity.y = -self.velocity.y
        } else if zombieY > maxY {
            zombieY = maxY
            self.velocity.y = -self.velocity.y
        }
    }

    func rotate(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat) {
        let shortest = shortestAngle(angle1: sprite.zRotation, angle2: direction.angle)
        let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
        sprite.zRotation += shortest.sign() * amountToRotate
    }

}
