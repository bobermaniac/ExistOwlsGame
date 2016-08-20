//
//  AnimationTextureSource.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class AnimationTextureSource {
    private let prepareBlock: (() -> [ SKTexture ])
    private var textures: [ SKTexture ]
    
    private(set) var count: Int
    
    init(withPattern pattern: String, count: Int) {
        self.prepareBlock = {
            return (1...count)
                .map({ String(format: pattern, $0) })
                .map({ SKTexture(imageNamed: $0) })
        }
        self.textures = []
        self.count = count
    }
    
    func prepareTextures() {
        self.textures = self.prepareBlock()
    }
    
    func texture(withIndex index: Int) -> SKTexture {
        return self.textures[index]
    }
}
