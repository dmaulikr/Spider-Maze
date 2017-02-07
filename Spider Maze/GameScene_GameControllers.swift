import Foundation
import SpriteKit
import GameController
extension GameScene {
    func setUpControllerObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.connectControllers), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameScene.controllerDisconnected), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    func controllerDisconnected(){
        self.isPaused = true
    }
    func connectControllers(){
        self.isPaused = false
        for controller in GCController.controllers() {
            if (controller.extendedGamepad != nil ) {
                controller.extendedGamepad?.valueChangedHandler = nil
                setUpExtendedController (controller: controller)
            }
            else if (controller.gamepad != nil )
            {
                controller.gamepad?.valueChangedHandler = nil
                setUpStandardController (controller: controller)
            }
        }
        //… to be continued…
        #if os(tvOS)
            for controller in GCController.controllers() {
                if ( controller.extendedGamepad != nil) {
                    //ignore
                } else if ( controller.gamepad != nil) {
                    //ignore
                } else if ( controller.microGamepad != nil)
                {
                    controller.microGamepad?.valueChangedHandler = nil
                    setUpMicroController( controller: controller )
                }
            }
        #endif
    }
    
    func setUpExtendedController( controller:GCController) {
        controller.extendedGamepad?.valueChangedHandler = {
            (gamepad: GCExtendedGamepad, element:GCControllerElement) in
            if (gamepad.controller?.playerIndex == .index1) {
                // this is player 1 playing the controller
            } else if (gamepad.controller?.playerIndex == .index2) {
                // this is player 2 playing the controller
            }
            
            if (gamepad.leftThumbstick == element) {
                if (gamepad.leftThumbstick.left.value > 0.2) {
                    print("pressed leftThumbstick left")
                } else if (gamepad.leftThumbstick.left.isPressed == false) {
                    print ("let go of leftThumbstick left")
                }
            } else if (gamepad.rightThumbstick == element) {
                if (gamepad.rightThumbstick.right.value > 0.2) {
                    print("pressed rightThumbstick right")
                } else if (gamepad.rightThumbstick.right.isPressed == false) {
                    print ("let go of rightThumbstick right")
                }
            } else if (gamepad.dpad == element) {
                if (gamepad.dpad.right.isPressed == true){
                    print("pressed dpad right")
                    let rotateRight = SKAction.rotate(toAngle: (CGFloat.pi * 3)/2, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateRight)
                    self.childNode(withName: "player1")?.position.x += 10
                }
 //               else if (gamepad.dpad.right.isPressed == false){
 //                   print("let go of dpad right")
 //               }
                if (gamepad.dpad.up.isPressed == true){
                    print("pressed dpad up")
                    let rotateUp = SKAction.rotate(toAngle: 0, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateUp)
                    self.childNode(withName: "player1")?.position.y += 10
                }
                if (gamepad.dpad.down.isPressed == true){
                    print("pressed dpad down")
                    let rotateDown = SKAction.rotate(toAngle: CGFloat.pi, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateDown)
                    self.childNode(withName: "player1")?.position.y -= 10
                }
//                else if (gamepad.dpad.up.isPressed == false){
//                    print("let go of dpad up")
//                }
                if (gamepad.dpad.left.isPressed == true){
                    print("pressed dpad left")
                    let rotateLeft = SKAction.rotate(toAngle: CGFloat.pi/2, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateLeft)
                    self.childNode(withName: "player1")?.position.x -= 10
                }
//                else if (gamepad.dpad.left.isPressed == false){
//                    print("let go of dpad left")
//                }
            }
            else if (gamepad.leftShoulder == element){
                if ( gamepad.leftShoulder.isPressed == true){
                    print("leftShoulder pressed")
                } else if ( gamepad.leftShoulder.isPressed == false) {
                    print("leftShoulder released")
                }
            }
            else if (gamepad.leftTrigger == element){
                if ( gamepad.leftTrigger.isPressed == true){
                    print("leftTrigger pressed")
                } else if ( gamepad.leftTrigger.isPressed == false) {
                    print("leftTrigger released")
                }
            }
            else if (gamepad.rightShoulder == element){
                if ( gamepad.rightShoulder.isPressed == true){
                    print("rightShoulder pressed")
                } else if ( gamepad.rightShoulder.isPressed == false) {
                    print("rightShoulder released")
                }
            }
            else if (gamepad.rightTrigger == element){
                if ( gamepad.rightTrigger.isPressed == true){
                    print("rightTrigger pressed")
                } else if ( gamepad.rightTrigger.isPressed == false) {
                    print("rightTrigger released")
                }
            } else if ( gamepad.buttonA == element) {
                if ( gamepad.buttonA.isPressed == true){
                    print("buttonA pressed")
                } else if ( gamepad.buttonA.isPressed == false) {
                    print("buttonA released")
                }
            } else if ( gamepad.buttonY == element) {
                if ( gamepad.buttonY.isPressed == true){
                    print("buttonY pressed")
                } else if ( gamepad.buttonY.isPressed == false) {
                    print("buttonY released")
                }
            } else if ( gamepad.buttonB == element) {
                if ( gamepad.buttonB.isPressed == true){
                    print("buttonB pressed")
                } else if ( gamepad.buttonB.isPressed == false) {
                    print("buttonB released")
                }
            } else if ( gamepad.buttonX == element) {
                if ( gamepad.buttonX.isPressed == true){
                    print("buttonX pressed")
                } else if ( gamepad.buttonX.isPressed == false) {
                    print("buttonX released")
                }
            }
        }
    }
    
    func setUpStandardController( controller:GCController) {
        controller.gamepad?.valueChangedHandler = {
            (gamepad: GCGamepad, element:GCControllerElement) in
            if (gamepad.controller?.playerIndex == .index1) {
                // this is player 1 playing the controller
            } else if (gamepad.controller?.playerIndex == .index2) {
                // this is player 1 playing the controller
            }
            if (gamepad.dpad == element) {
                if (gamepad.dpad.right.isPressed == true){
                    print("pressed dpad right")
                } else if (gamepad.dpad.right.isPressed == false){
                    print("let go of dpad right")
                }
                if (gamepad.dpad.left.isPressed == true){
                    print("pressed dpad left")
                } else if (gamepad.dpad.left.isPressed == false){
                    print("let go of dpad left")
                }
            } else if (gamepad.leftShoulder == element){
                if ( gamepad.leftShoulder.isPressed == true){
                    print("leftShoulder pressed")
                } else if ( gamepad.leftShoulder.isPressed == false) {
                    print("leftShoulder released")
                }
            }
            else if ( gamepad.buttonA == element) {
                if ( gamepad.buttonA.isPressed == true){
                    print("buttonA pressed")
                } else if ( gamepad.buttonA.isPressed == false) {
                    print("buttonA released")
                }
            } else if ( gamepad.buttonY == element) {
                if ( gamepad.buttonY.isPressed == true){
                    print("buttonY pressed")
                } else if ( gamepad.buttonY.isPressed == false) {
                    print("buttonY released")
                }
            } else if ( gamepad.buttonB == element) {
                if ( gamepad.buttonB.isPressed == true){
                    print("buttonB pressed")
                } else if ( gamepad.buttonB.isPressed == false) {
                    print("buttonB released")
                }
            } else if ( gamepad.buttonX == element) {
                if ( gamepad.buttonX.isPressed == true){
                    print("buttonX pressed")
                } else if ( gamepad.buttonX.isPressed == false) {
                    print("buttonX released")
                }
            }
        }
    }
    #if os(tvOS)
    func setUpMicroController( controller:GCController) {
        controller.microGamepad?.valueChangedHandler = {
            (gamepad:GCMicroGamepad, element:GCControllerElement) in
            gamepad.reportsAbsoluteDpadValues = true
            gamepad.allowsRotation = true
            if ( gamepad.buttonX == element) {
                
                if (gamepad.buttonX.isPressed == true){
                    //Button X is the play / pause button on the new Apple TV remote
                    print("pressed buttonX on the microGamepad")
                } else if (gamepad.buttonX.isPressed == false ){
                    print("released buttonX on the microGamepad")
                }
            } else if ( gamepad.buttonA == element) {
                //Button A is usually activated by a harder press on the touchpad.
                if (gamepad.buttonA.isPressed == true){
                    print("pressed buttonA on the microGamepad")
                } else if (gamepad.buttonA.isPressed == false ){
                    print("released buttonA on the microGamepad")
                }
            }
            else if (gamepad.dpad == element) {
                if (gamepad.dpad.right.value > 0.1) {
                    print("pressed right")
                    let rotateRight = SKAction.rotate(toAngle: (CGFloat.pi * 3)/2, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateRight)
                    self.childNode(withName: "player1")?.position.x += 10
                    
                } 
                // else if (gamepad.dpad.right.value == 0.0) {
                // print("released right")
            //}
            if (gamepad.dpad.left.value > 0.1) {
                print("pressed left")
                let rotateLeft = SKAction.rotate(toAngle: CGFloat.pi/2, duration: 0.0)
                self.childNode(withName: "player1")?.run(rotateLeft)
                self.childNode(withName: "player1")?.position.x -= 10
            }
                if (gamepad.dpad.up.value > 0.1) {
                    print("pressed up")
                    let rotateUp = SKAction.rotate(toAngle: 0, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateUp)
                    self.childNode(withName: "player1")?.position.y += 10
                }
                if (gamepad.dpad.down.value > 0.1) {
                    print("pressed down")
                    let rotateDown = SKAction.rotate(toAngle: CGFloat.pi, duration: 0.0)
                    self.childNode(withName: "player1")?.run(rotateDown)
                    self.childNode(withName: "player1")?.position.y -= 10
                }
            // else if (gamepad.dpad.left.value == 0.0) {
            // print("released left")
        //}
    }
    }
    }
    #endif
}
