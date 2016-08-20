//
//  KittyChaseScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 16/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class KittyChaseSceneFactory {
    func makeScene() -> SKScene {
        return ExampleQuestScene(fileNamed: "ExampleQuestScene")!
    }
}

class KittyChaseScene : SKScene {
    var leftToeTap : SKNode!
    var rightToeTap : SKNode!
    var leftJumpTap : SKNode!
    var rightJumpTap : SKNode!
    var runningMan : SKSpriteNode!
    var label: SKLabelNode!
    
    let rhytmProcessor : InputRhytmProcessor = InputRhytmProcessor()
    var animationPerformer : BPMControlledAnimationPerformer! = nil
    
    override func didMove(to view: SKView) {
        leftToeTap = childNode(withName: "leftRunTap")!
        rightToeTap = childNode(withName: "rightRunTap")!
        leftJumpTap = childNode(withName: "leftJumpTap")!
        rightJumpTap = childNode(withName: "rightJumpTap")!
        runningMan = childNode(withName: "runningMan")! as! SKSpriteNode
        label = childNode(withName: "label")! as! SKLabelNode
        
        let textures = AnimationTextureSource(withPattern: "animation.pc.run.1.%02d", count: 12)
        textures.prepareTextures()
        animationPerformer = BPMControlledAnimationPerformer(animating: runningMan, withTextures: textures)
    }
    
    var pressedPad : PadDisposition?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let nodes = self.nodes(at: touch.location(in: self))
        if nodes.contains(leftToeTap) {
            pressedPad = PadDisposition.Left
        }
        if (nodes.contains(rightToeTap)) {
            pressedPad = PadDisposition.Right
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let pressedPad = self.pressedPad {
            defer {
                self.pressedPad = nil
            }
            switch rhytmProcessor.consume(disposition: pressedPad, inTime: currentTime) {
            case .Broken:
                label.text = ":("
                animationPerformer.setBPM(60)
            case .Pending(count: _):
                label.text = "Preparing..."
                animationPerformer.setBPM(60)
            case .BPM(let bpm):
                label.text = "bpm: ".appendingFormat("%d", bpm)
                animationPerformer.setBPM(bpm)
            }
        }
        animationPerformer.update(currentTime)
    }
}
