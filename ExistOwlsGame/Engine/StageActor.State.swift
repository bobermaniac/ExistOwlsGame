//
//  StageActor.State.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 21/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

protocol StageActorStateObserver : class {
    func actorDidChangeState(_ actor: StageActor, to state: StageActor.State)
}

extension StageActor {
    public enum State {
        case None
        case Idle
        case Walk
        case Animation(name: String)
    }
}
