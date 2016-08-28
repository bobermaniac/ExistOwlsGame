//
//  SKETextureSheet.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

class TextureSheet {
    private let _textures: [ Index : SKTexture ]
    private let _rows : Int
    private let _columns : Int
    
    init(withSheet sheet: SKTexture, rows rowsCount: Int, columns columnsCount: Int) {
        _rows = rowsCount
        _columns = columnsCount
        
        let indexes = (0..<rowsCount).product(with: (0..<columnsCount), { Index(row: $0, column: $1) })
        let tileSize = CGSize(width: 1.0 / CGFloat(columnsCount), height: 1.0 / CGFloat(rowsCount))
        
        _textures = indexes.map({ index -> (Index, SKTexture) in
            let rect = CGRect(origin: CGPoint(x: tileSize.width * CGFloat(index.column), y:tileSize.height * CGFloat(index.row)), size: tileSize)
            return (index, SKTexture(rect: rect, in: sheet))
        }).dictionary(literal: { ($0.0, $0.1) })
    }
    
    func texture(row: Int, column: Int) -> SKTexture {
        return _textures[Index(row: row, column: column)]!
    }
    
    func textures(inRow row:Int) -> [ SKTexture ] {
        return (0..<_columns).map({ Index(row: row, column: $0) }).map({ _textures[$0]! })
    }
    
    struct Index : Hashable {
        let row : Int
        let column: Int
        
        init(row: Int, column: Int) {
            self.row = row
            self.column = column
        }
        
        public var hashValue: Int {
            return self.row.hashValue * 17 ^ self.column.hashValue
        }
        
        public static func ==(lhs: Index, rhs: Index) -> Bool {
            return lhs.column == rhs.column && lhs.row == rhs.row
        }
    }
}
