//
//  TextureSheetTests.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 05/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import XCTest
import OWLAnimations

class TextureSheetTests: XCTestCase {
    final class MockTexture: Texture {
        public let size: Size2D
        
        public let rect: Box2D?
        public let parent: MockTexture?
        
        public init(withSize size: Size2D) {
            self.size = size
            self.rect = nil
            self.parent = nil
        }
        
        public init(withParent parent: MockTexture, rect: Box2D) {
            self.size = rect.size
            self.rect = rect
            self.parent = parent
        }
        
        func rect(_ rect: Box2D) -> MockTexture {
            return MockTexture(withParent: self, rect: rect)
        }
    }
    
    var size: Size2D! = nil
    var texture: MockTexture! = nil
    
    override func setUp() {
        super.setUp()
        
        size = Size2D(width: 100, height: 100)
        texture = MockTexture(withSize: size)
    }
    
    func testCount() {
        let rows: UInt = 10
        let columns: UInt = 10
        let sheet = TextureSheetImpl(withTexture: texture, rows: rows, columns: columns)
        
        XCTAssertEqual(sheet.rowsCount, rows)
        XCTAssertEqual(sheet.columnsCount, columns)
    }
    
    func testSize() {
        let rows: UInt = 10
        let columns: UInt = 10
        let sheet = TextureSheetImpl(withTexture: texture, rows: rows, columns: columns)
        
        let referenceSize = Size2D(width: texture.size.width / Double(columns), height: texture.size.height / Double(rows))
        for r in 0..<rows {
            for  c in 0..<columns {
                XCTAssertEqual(sheet.texture(row: r, column: c).size, referenceSize)
            }
        }
    }
    
    func testFrames() {
        let rows: UInt = 10
        let columns: UInt = 10
        let sheet = TextureSheetImpl(withTexture: texture, rows: rows, columns: columns)
        
        let referenceSize = Size2D(width: texture.size.width / Double(columns), height: texture.size.height / Double(rows))
        for r in 0..<rows {
            for  c in 0..<columns {
                let referenceBox = Box2D(left: referenceSize.width * Double(c), top: referenceSize.height * Double(r), width: referenceSize.width, height: referenceSize.height)
                XCTAssertEqual(sheet.texture(row: r, column: c).rect!, referenceBox)
            }
        }
    }
    
    func testParents() {
        let rows: UInt = 10
        let columns: UInt = 10
        let sheet = TextureSheetImpl(withTexture: texture, rows: rows, columns: columns)
        
        for r in 0..<rows {
            for  c in 0..<columns {
                XCTAssert(sheet.texture(row: r, column: c).parent! === texture)
            }
        }
    }
}
