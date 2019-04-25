//
//  GameScene.swift
//  pong
//
//  Created by zach calcagno on 4/15/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

let ballCategory: UInt32 = 1 // 0x1 << 0
let bottomCategory: UInt32 = 2
let topCategory: UInt32 = 4
let leftCategory: UInt32 = 8
let rightCategory: UInt32 = 16
let paddleCategory: UInt32 = 32

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var topPaddle = SKSpriteNode()
    var bottomPaddle = SKSpriteNode()
    var rightPaddle = SKSpriteNode()
    var leftPaddle = SKSpriteNode()
    var ball = SKSpriteNode()
    
    override func didMove(to view: SKView) {
       physicsWorld.contactDelegate = self
        
        let bottomLeft = CGPoint(x: frame.origin.x, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
        let topLeft = CGPoint(x: frame.origin.x, y: -frame.origin.y)
        let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
        
        let top = SKNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        self.addChild(top)
        
        let left = SKNode()
        left.name = "bottom"
        left.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: bottomLeft)
        self.addChild(left)
        
        let bottom = SKNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        self.addChild(bottom)
        
        let right = SKNode()
        right.name = "bottom"
        right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
        self.addChild(right)
        
        
        topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
        bottomPaddle = self.childNode(withName: "bottomPaddle") as! SKSpriteNode
        rightPaddle = self.childNode(withName: "rightPaddle") as! SKSpriteNode
        leftPaddle = self.childNode(withName: "leftPaddle") as! SKSpriteNode
        
        topPaddle.physicsBody?.categoryBitMask = paddleCategory
        bottomPaddle.physicsBody?.categoryBitMask = paddleCategory
        rightPaddle.physicsBody?.categoryBitMask = paddleCategory
        leftPaddle.physicsBody?.categoryBitMask = paddleCategory
        
        bottom.physicsBody?.categoryBitMask = bottomCategory
        top.physicsBody?.categoryBitMask = topCategory
        right.physicsBody?.categoryBitMask = rightCategory
        left.physicsBody?.categoryBitMask = leftCategory
        
        ball.physicsBody?.categoryBitMask = ballCategory
        
        ball.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory|paddleCategory
    }
    func didBegin(_ contact: SKPhysicsContact) {
       // print(contact.bodyA.node?.name)
       // print(contact.bodyB.node?.name)
        if contact.bodyA.categoryBitMask == bottomCategory{
            changePaddle(node: bottomPaddle)
        } else if contact.bodyA.categoryBitMask == topCategory{
            changePaddle(node: topPaddle)
        }else if contact.bodyA.categoryBitMask == leftCategory{
            changePaddle(node: leftPaddle)
        } else if contact.bodyA.categoryBitMask == rightCategory{
            changePaddle(node: rightPaddle)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        leftPaddle.run(SKAction.moveTo( y: location.x, duration: 0.2))
        rightPaddle.run(SKAction.moveTo(y: -location.x, duration: 0.2))
        bottomPaddle.run(SKAction.moveTo(x: -location.x, duration: 0.2))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
        leftPaddle.run(SKAction.moveTo( y: location.x, duration: 0.2))
        rightPaddle.run(SKAction.moveTo(y: -location.x, duration: 0.2))
        bottomPaddle.run(SKAction.moveTo(x: -location.x, duration: 0.2))
    }
    func changePaddle(node: SKSpriteNode){
        if node.color == .yellow {
            node.removeAllActions()
            node.removeFromParent()
            
        }
        node.color = .yellow
    }
    
}
