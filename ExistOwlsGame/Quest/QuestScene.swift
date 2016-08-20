//
//  QuestScene.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

protocol QuestSceneEvents {
    
}

protocol QuestSceneActors {
    var PC : SKSpriteNode { get }
}

class QuestScene : SKScene {
    // MARK: Public interface
    /**
     Callback object to notify quest scene events
    */
    var events : QuestSceneEvents? = nil
    /**
     Protocol to manage scene actors
    */
    var actors : QuestSceneActors? = nil

    // MARK: Private variables
    // MARK: Private methods
}
