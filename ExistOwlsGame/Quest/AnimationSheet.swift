//
//  PCTextureSheet.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum Direction : Int {
    case Left
    case Right
    case Top
    case Bottom
}

enum Animation : Hashable {
    case Idle(Direction)
    case Walk(Direction)
    
    var hashValue: Int {
        switch self {
        case .Idle(let direction):
            return 17 ^ direction.hashValue
        case .Walk(let direction):
            return 91 ^ direction.hashValue
        }
    }
    
    private var typeCode : Int {
        switch self {
        case .Idle(let direction):
            return direction.rawValue
        case .Walk(let direction):
            return 10 + direction.rawValue
        }
    }
    
    static func ==(lhs: Animation, rhs: Animation) -> Bool {
        return lhs.typeCode == rhs.typeCode
    }
}

class TexturesExtractor {
    typealias ExtractionMethod = (_ sheet: TextureSheet) -> [ SKTexture ]
    
    let extract : ExtractionMethod
    
    init(extracting method: ExtractionMethod) {
        self.extract = method
    }
}

class AnimationSheet {
    init(textureSheet sheet: TextureSheet) {
        _textureSheet = sheet
    }
    
    func animation(type: Animation) -> SKAction {
        let textures = _extractTextures(for: type)
        if (textures.count == 1) {
            return SKAction.setTexture(textures.first!)
        }
        return SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
    }
    
    private let _textureSheet: TextureSheet
    private static let _extractors : [ Animation : TexturesExtractor ] = _createExtractors()
    
    private func _extractTextures(for type: Animation) -> [ SKTexture ] {
        return AnimationSheet._extractors[type]?.extract(_textureSheet) ?? []
    }
    
    private class func _createExtractors() -> [ Animation : TexturesExtractor ] {
        let idleLeft = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 1) ] })
        let idleRight = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 3) ] })
        let idleTop = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 2) ] })
        let idleBottom = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 0) ] })
        
        let walkLeft = TexturesExtractor(extracting: { $0.textures(inRow: 3) })
        let walkRight = TexturesExtractor(extracting: { $0.textures(inRow: 2) })
        let walkTop = TexturesExtractor(extracting: { $0.textures(inRow: 1) })
        let walkBottom = TexturesExtractor(extracting: { $0.textures(inRow: 0) })
        return [
            Animation.Idle(.Left) : idleLeft,
            Animation.Idle(.Right) : idleRight,
            Animation.Idle(.Top) : idleTop,
            Animation.Idle(.Bottom) : idleBottom,
            Animation.Walk(.Left) : walkLeft,
            Animation.Walk(.Right) : walkRight,
            Animation.Walk(.Top) : walkTop,
            Animation.Walk(.Bottom) : walkBottom,
        ];
    }
}
