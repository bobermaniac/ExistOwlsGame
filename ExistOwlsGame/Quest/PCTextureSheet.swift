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
    typealias ExtractionMethod = (_ sheet: SKETextureSheet) -> [ SKTexture ]
    
    let extract : ExtractionMethod
    
    init(extracting method: ExtractionMethod) {
        self.extract = method
    }
}

class AnimationSheet {
    init(textureSheet sheet: SKETextureSheet) {
        _textureSheet = sheet
    }
    
    func animation(type: Animation) -> SKAction {
        let textures = _extractTextures(for: type)
        if (textures.count == 1) {
            return SKAction.setTexture(textures.first!)
        }
        return SKAction.animate(with: textures, timePerFrame: 0.1)
    }
    
    private let _textureSheet: SKETextureSheet
    private static let _extractors : [ Animation : TexturesExtractor ] = _createExtractors()
    
    private func _extractTextures(for type: Animation) -> [ SKTexture ] {
        return AnimationSheet._extractors[type]?.extract(_textureSheet) ?? []
    }
    
    private class func _createExtractors() -> [ Animation : TexturesExtractor ] {
        let ls = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 1) ] })
        let rs = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 3) ] })
        let ts = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 2) ] })
        let bs = TexturesExtractor(extracting: { [ $0.texture(row:4, column: 0) ] })
        
        return [
            Animation.Idle(.Left) : ls,
            Animation.Idle(.Right) : rs,
            Animation.Idle(.Top) : ts,
            Animation.Idle(.Bottom) : bs,
        ];
    }
}
