//
//  TextureSheet.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation
import OWLCore

public protocol TextureSheet {
    associatedtype TextureType: Texture
    
    var rowsCount: UInt { get }
    var columnsCount: UInt { get }
    
    func texture(row: UInt, column: UInt) -> TextureType
    func textures(inRow row: UInt) -> [ TextureType ]
    func textures(inColumn column: UInt) -> [ TextureType ]
}

public final class TextureSheetImpl<T: TextureFactory> : TextureSheet {
    public typealias TextureType = T.TextureType
    
    private typealias Index = IntegralIndex2
    private let _textures: [ Index : TextureType ]
    
    public let rowsCount: UInt
    public let columnsCount: UInt
    
    public init(withTexture sheet: TextureType, rows rowsCount: UInt, columns columnsCount: UInt, factory: T) {
        self.rowsCount = rowsCount
        self.columnsCount = columnsCount
        
        let patchSize = Size2D(width: sheet.size.width / Double(columnsCount), height: sheet.size.height / Double(rowsCount))
        let indicies = product(0..<rowsCount, with: 0..<columnsCount, Index.init)
        let origins = indicies.map { Point2D(left: patchSize.width * Double($0.column), top: patchSize.height * Double($0.row)) }
        let frames = origins.map { Box2D(origin: $0, size: patchSize) }
        let textures = frames.map { factory.rect($0, from: sheet) }
        
        _textures = zip(indicies, textures).dictionary(literal: { ($0.0, $0.1) })
    }
    
    public func texture(row: UInt, column: UInt) -> TextureType {
        return _textures[Index(row: row, column: column)]!
    }
    
    public func textures(inRow row: UInt) -> [ TextureType ] {
        return (0..<columnsCount).map({ Index(row: row, column: $0) }).map({ _textures[$0]! })
    }
    
    public func textures(inColumn column: UInt) -> [ TextureType ] {
        return (0..<rowsCount).map({ Index(row: $0, column: column) }).map({ _textures[$0]! })
    }
}
