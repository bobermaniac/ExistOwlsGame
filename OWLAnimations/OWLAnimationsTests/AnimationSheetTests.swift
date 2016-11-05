//
//  AnimationSheetTests.swift
//  OWLAnimations
//
//  Created by Victor Bryksin on 06/11/2016.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import XCTest
import OWLAnimations

class AnimationSheetTests: XCTestCase {
    static let referenceColumn: UInt = 5
    static let referenceTimePerFrame: TimeInterval = 2
    
    final class MockTexture: Texture {
        let size: Size2D = Size2D(width: 1, height: 1)
        
        func rect(_ rect: Box2D) -> MockTexture {
            return MockTexture()
        }
    }
    
    final class MockTextureSheet: TextureSheet {
        typealias TextureType = MockTexture
        
        let rowsCount: UInt = 5
        let columnsCount: UInt = 5
        
        func texture(row: UInt, column: UInt) -> TextureType {
            fatalError()
        }
        
        func textures(inRow row: UInt) -> [ TextureType ] {
            fatalError()
        }
        
        func textures(inColumn column: UInt) -> [ TextureType ] {
            guard column == referenceColumn else { fatalError() }
            return [ MockTexture() ]
        }
    }
    
    final class MockTextureAnimationFactory: TextureAnimationFactory {
        func makeAnimation<F: ActionFactory, S: TextureSheet>(from sheet: S, using factory: F) -> F.ActionType where F.TextureType == S.TextureType {
            return factory.animate(with: sheet.textures(inColumn: referenceColumn), timePerFrame: referenceTimePerFrame)
        }
    }
    
    final class MockAction {
        
    }
    
    static let referenceAction = MockAction()
    
    final class MockActionFactory: ActionFactory {
        public func repeatForever(_ action: MockAction) -> MockAction {
            fatalError()
        }

        public func setTexture(_ texture: MockTexture) -> MockAction {
            fatalError()
        }

        typealias ActionType = MockAction
        typealias TextureType = MockTexture
        
        func group(_ actions: [ MockAction ]) -> MockAction {
            fatalError()
        }
        
        func sequence(_ actions: [ MockAction ]) -> MockAction {
            fatalError()
        }
        
        func animate(with textures: [ MockTexture ], timePerFrame sec: TimeInterval) -> MockAction {
            guard sec == referenceTimePerFrame else { fatalError() }
            return referenceAction
        }
    }
    
    enum MockAnimation: Int {
        case any
    }
    
    func testAnimationCreation() {
        let builder = AnimationSheetImplBuilder<MockTextureSheet, MockAnimation>()
        builder.sheet = MockTextureSheet()
        builder.factories[.any] = MockTextureAnimationFactory()
        
        let animationSheet = try! builder.build()
        let factory = MockActionFactory()
        let action = animationSheet.animation(.any, using: factory)
        
        XCTAssert(action === AnimationSheetTests.referenceAction)
    }
}
