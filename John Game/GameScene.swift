//
//  GameScene.swift
//  John Game
//
//  Created by John Soanes on 21/12/2015.
//  Copyright (c) 2015 John Soanes. All rights reserved.
//

import SpriteKit

var bird = SKSpriteNode ()
var bg = SKSpriteNode()
var ground = SKNode()
var pipe1 = SKSpriteNode()
var pipe2 = SKSpriteNode()

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        // Texture
        
        let bgTexture = SKTexture(imageNamed: "bg.png")
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        let replaceBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let moveBGForever = SKAction.repeatActionForever(SKAction.sequence([movebg,replaceBg]))
      
        //Background Looping Code
        for var i : CGFloat=0; i<3; i++ {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
            bg.runAction(moveBGForever)
            self.addChild(bg)
        }
        
        // Bird Animation
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        let animation = SKAction.animateWithTextures([birdTexture,birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        //Bird gravity
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height/2)
        bird.physicsBody!.dynamic = true
        self.addChild(bird)
        
        //Add the Ground
        
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody!.dynamic = false
        self.addChild(ground)
        
        
        //Add the Pipes on a timer
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        
        
        func makePipes() {
        
        //Pipe Random Position Set
        let gapHeight = bird.size.height * 4
        let moveAmount =  arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffset = CGFloat(moveAmount)  - self.frame.size.height / 4
        
        //Pipe Animation
        
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes,removePipes])
        
        
        //Add  Pipe 1
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeTexture.size().height/2 + gapHeight / 2 + pipeOffset)
        pipe1.runAction(moveAndRemovePipes)
        self.addChild(pipe1)
        
        //Add Pipe 2
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipeTexture.size().height/2 - gapHeight / 2 + pipeOffset )
        pipe2.runAction(moveAndRemovePipes)
        self.addChild(pipe2)
      
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        //Bird Touch
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
        
      
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
    
    }
}
