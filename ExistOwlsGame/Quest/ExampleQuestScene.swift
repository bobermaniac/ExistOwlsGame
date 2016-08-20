//
//  ExampleQuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class ExampleTextureBatch {
    let PCSheet : SKETextureSheet
    let PCAnimation : AnimationSheet
    
    init() {
        let PCSheetTexture = SKTexture(imageNamed: "walking_boy")
        PCSheet = SKETextureSheet(withSheet: PCSheetTexture, rows: 5, columns: 11)
        
        PCAnimation = AnimationSheet(textureSheet: PCSheet)
    }
}

class ExampleQuestScene : QuestScene, QuestSceneActors {
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.texture = _textures.PCSheet.texture(row: 0, column: 0)
        
        _PC.run(_textures.PCAnimation.animation(type: .Idle(.Top)))
    }
    
    // MARK: QuestSceneActors implementation
    var PC: SKSpriteNode {
        return _PC
    }
}
