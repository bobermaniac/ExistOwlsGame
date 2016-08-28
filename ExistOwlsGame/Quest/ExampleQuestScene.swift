//
//  ExampleQuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class ExampleTextureBatch {
    let PCSheet : TextureSheet
    let PCAnimation : AnimationSheet
    
    init() {
        let PCSheetTexture = SKTexture(imageNamed: "walking_boy")
        PCSheet = TextureSheet(withSheet: PCSheetTexture, rows: 5, columns: 11)
        
        PCAnimation = AnimationSheet(textureSheet: PCSheet)
    }
}

class ExampleQuestScene : SKScene {
    
    // MARK: - StagePresenter implementation

    func presentStage(on view: SKView) {
        self.scaleMode = .aspectFill
        view.presentScene(self)
    }

    // MARK: -
    
    private var _textures : ExampleTextureBatch!
    private var _PC : SKSpriteNode!
    private var _mainCamera : SKCameraNode!
    
    override func didMove(to view: SKView) {
        _textures = ExampleTextureBatch()
        
        _PC = childNode(withName: "Sprite_PC") as? SKSpriteNode
        _PC.texture = _textures.PCSheet.texture(row: 0, column: 0)
        
        _mainCamera = childNode(withName: "mainCamera") as? SKCameraNode
        
        _PC.run(_textures.PCAnimation.animation(type: .Idle(.Top)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    // MARK: QuestSceneActors implementation
    
    func pcMove(to point: CGPoint) {
        var direction = Direction.Top
        if (abs(point.x - _PC.position.x) < abs(point.y - _PC.position.y)) {
            direction = point.y > _PC.position.y ? .Top : .Bottom
        } else {
            direction = point.x > _PC.position.x ? .Left : .Right
        }
        _PC.removeAllActions()
        _PC.run(_textures.PCAnimation.animation(type: .Walk(direction)))
        let length = point.distance(to: _PC.position)
        let time = length / 70
        _PC.run(SKAction.move(to: point, duration: TimeInterval(time)), completion: {
            self._PC.removeAllActions()
            self._PC.run(self._textures.PCAnimation.animation(type: .Idle(direction)))
        });
    }
}
