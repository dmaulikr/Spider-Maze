import SpriteKit
import UIKit
import GameplayKit
import Foundation






class GameScene: SKScene, SKPhysicsContactDelegate {
  
    var spider : SKSpriteNode = SKSpriteNode(imageNamed: "blackSpider1")
    
    var spiderWalkingFrames : [SKTexture]!
//    func swipedRight(sender:UISwipeGestureRecognizer){
//        print("swiped right")
//    }
//    
//    func swipedLeft(sender:UISwipeGestureRecognizer){
//        print("swiped left")
//    }
//    
//    func swipedUp(sender:UISwipeGestureRecognizer){
//        print("swiped up")
//    }
//    
//    func swipedDown(sender:UISwipeGestureRecognizer){
//        print("swiped down")
//    }
    
 
        
        override func didMove(to view: SKView) {
            physicsWorld.contactDelegate = self
//            if let goal = self.childNode(withName: "goal"){
//            let goalCategory = goal.physicsBody?.contactTestBitMask
//            
//            if let spider = self.childNode(withName: "player1"){
//                
//                spider.physicsBody?.contactTestBitMask = goalCategory!
//            }
//            }
            let timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.spawnObstacle(timer:)), userInfo: nil, repeats: true)
          //  RunLoop.main.add(timer, forMode: CFRunLoopMode)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            let camera = SKCameraNode()
            self.camera = camera
            camera.position = CGPoint(x: self.size.width / 2, y: spider.position.y + 400)
            let moveForward = SKAction.moveBy(x: 0, y: 50, duration: 1.0)
            camera.run(SKAction.repeatForever(moveForward))
            addChild(camera)
            /* Setup your scene here */
            
//            let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
//            swipeRight.direction = .right
//            view.addGestureRecognizer(swipeRight)
//            
//            
//            let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
//            swipeLeft.direction = .left
//            view.addGestureRecognizer(swipeLeft)
//            
//            
//            let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
//            swipeUp.direction = .up
//            view.addGestureRecognizer(swipeUp)
//            
//            
//            let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
//            swipeDown.direction = .down
//            view.addGestureRecognizer(swipeDown)
            
                    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
                    swipeRight.direction = UISwipeGestureRecognizerDirection.right
                    self.view!.addGestureRecognizer(swipeRight)
            
                    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
                    swipeDown.direction = UISwipeGestureRecognizerDirection.down
                    self.view!.addGestureRecognizer(swipeDown)
            
                    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
                    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
                    self.view!.addGestureRecognizer(swipeLeft)
            
                    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
                    swipeUp.direction = UISwipeGestureRecognizerDirection.up
                    self.view!.addGestureRecognizer(swipeUp)

            
            
    }
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
       
//        if let playerOne = self.childNode(withName: "player1"){
//           playerOne.position.y += 1
//            if let cam = self.childNode(withName: "follow"){
//                cam.position = CGPoint(x: playerOne.position.x, y: playerOne.position.y + 200)
//            }
//        }
        
        
    }
        func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.right:
                    if let playerOne = self.childNode(withName: "player1"){
                    
                    playerOne.position = CGPoint(x: playerOne.position.x + 20, y: playerOne.position.y)
                    }
                    
                    print("Swiped right")
                    
                case UISwipeGestureRecognizerDirection.down:
                    if let playerOne = self.childNode(withName: "player1"){
                        
                        playerOne.position = CGPoint(x: playerOne.position.x, y: playerOne.position.y - 32)
                    }
                    
                    print("Swiped down")
                    
                case UISwipeGestureRecognizerDirection.left:
                    if let playerOne = self.childNode(withName: "player1"){
                        
                        playerOne.position = CGPoint(x: playerOne.position.x - 20, y: playerOne.position.y)
                    }
                    print("Swiped left")
                    
                case UISwipeGestureRecognizerDirection.up:
                    if let playerOne = self.childNode(withName: "player1"){
                        
                        playerOne.position = CGPoint(x: playerOne.position.x, y: playerOne.position.y + 8)
                    }
                    print("Swiped up")
                
                   
                    
                    
                    
                default:
                    break
                }
            }
        }
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        if contact.bodyA.node == spider || contact.bodyB == spider {
            spider.isHidden = true
            speed = 0
        }
    }
    func spawnObstacle(timer: Timer) {
        if spider.isHidden {
            timer.invalidate()
            return
        }
        
        let spriteGenerator = GKShuffledDistribution(lowestValue: 1, highestValue: 3)
        let obstacle = SKSpriteNode(imageNamed: "obstacle\(spriteGenerator.nextInt())")
        obstacle.xScale = 0.15
        obstacle.yScale = 0.15
  
        let physicsBody = SKPhysicsBody(circleOfRadius: 100)
        physicsBody.contactTestBitMask = 0x00000001
        physicsBody.pinned = true
        physicsBody.allowsRotation = false
        obstacle.physicsBody = physicsBody
        
        let center = size.width/2.0, difference = CGFloat(360.0)
        var x: CGFloat = 0
        
        let laneGenerator = GKShuffledDistribution(lowestValue: 1, highestValue: 3)
        switch laneGenerator.nextInt() {
        case 1:
            x = center - difference
        case 2:
            x = center + difference/2
        case 3:
            x = center + difference
        default:
            fatalError("Number outside of [1, 3] generated")
        }
        
        obstacle.position = CGPoint(x: x, y: self.spider.position.y + 900)
        addChild(obstacle)
    }
    

}
