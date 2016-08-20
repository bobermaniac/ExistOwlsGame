//
//  KittyChase.PCAnimationPerformer.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 16/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class BPMControlledAnimationPerformer {
    let textureSource : AnimationTextureSource
    let node: SKSpriteNode
    
    init(animating spriteNode: SKSpriteNode, withTextures textures: AnimationTextureSource) {
        node = spriteNode
        
        node.texture = textures.texture(withIndex: 0)
        _index = LoopIndex(startingWith: 0, maximum: textures.count - 1)
        textureSource = textures
    }
    
    var _lastFrame : TimeInterval?
    var _delta : TimeInterval = 0.08
    var _index : LoopIndex
    
    func setBPM(_ bpm: Int) {
        _delta = (60.0 / (Double(bpm) / 2)) / 12.0
    }
    
    func update(_ currentTime: TimeInterval) {
        guard var lastFrame = _lastFrame else {
            _lastFrame = currentTime
            return
        }
        var updateTexture = false
        while (currentTime - lastFrame > _delta) {
            lastFrame = lastFrame + _delta
            _index.increment()
            updateTexture = true
        }
        if updateTexture {
            _lastFrame = lastFrame
            node.texture = textureSource.texture(withIndex: _index.value)
        }
    }
}
