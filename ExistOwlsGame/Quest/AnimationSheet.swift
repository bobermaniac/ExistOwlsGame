//
//  PCTextureSheet.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class TexturesExtractor {
    typealias ExtractionMethod = (_ sheet: TextureSheet) -> [ SKTexture ]
    
    let extract : ExtractionMethod
    
    init(extracting method: @escaping ExtractionMethod) {
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
    
    private func _extractTextures(for type: Animation) -> [ SKTexture ] {
        return AnimationSheet._extractors[type]?.extract(_textureSheet) ?? []
    }
    
    private static let _extractors : [ Animation : TexturesExtractor ] = _createExtractors()   
    
    private class func _at(row: Int, column: Int) -> TexturesExtractor.ExtractionMethod {
        return { [ $0.texture(row: row, column: column) ] }
    }
    
    private class func _in(row: Int) -> TexturesExtractor.ExtractionMethod {
        return { $0.textures(inRow: row) }
    }
    
    private class func _extractor(row: Int, column: Int) -> TexturesExtractor {
        return TexturesExtractor(extracting: _at(row: row, column: column))
    }
    
    private class func _extractor(row: Int) -> TexturesExtractor {
        return TexturesExtractor(extracting: _in(row: row))
    }
    
    private class func _createExtractors() -> [ Animation : TexturesExtractor ] {
        return [
            Animation.idleLeft : _extractor(row: 4, column: 1),
            Animation.idleRight : _extractor(row: 4, column: 3),
            Animation.idleTop : _extractor(row: 4, column: 2),
            Animation.idleBottom : _extractor(row: 4, column: 0),
            Animation.walkLeft : _extractor(row: 3),
            Animation.walkRight : _extractor(row: 2),
            Animation.walkTop : _extractor(row: 1),
            Animation.walkBottom : _extractor(row: 0),
        ];
    }
}

extension AnimationSheet {
    public enum Animation : String {
        case idleLeft = "idle left"
        case idleRight = "idle right"
        case idleTop = "idle top"
        case idleBottom = "idle bottom"
        case walkLeft = "walk left"
        case walkTop = "walk top"
        case walkRight = "walk right"
        case walkBottom = "walk bottom"
    }
}
