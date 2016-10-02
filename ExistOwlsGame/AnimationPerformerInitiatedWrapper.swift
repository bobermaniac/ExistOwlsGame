//
//  AnimationPerformerInitiatedWrapper.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 20/09/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

class AnimationPerformerInitiatedWrapper : AnimationPerformer {
    private let _performer : AnimationPerformerWithCompletion
    private let _event : Event
    
    private func _onComplete(command: AnimationCommand, on animatable: Animatable) -> AnimationPerformerCompletion {
        let event = self._event
        return {
            self.events?.command(command, finishedOn: animatable, causedBy: event)
        }
    }
    
    var events: AnimationEventRecognizer? {
        get { return _performer.events }
        set { }
    }
    
    init(withPerformer performer: AnimationPerformerWithCompletion, event: Event) {
        _performer = performer
        _event = event
    }
    
    func perform(command: AnimationCommand, on animatable: Animatable, using sheet: AnimationSheet?) {
        let complete = _onComplete(command: command, on: animatable)
        self.events?.command(command, startedOn: animatable, causedBy: _event)
        _performer.perform(command: command, on: animatable, using: sheet, complete: complete)
    }
}

extension AnimationPerformerWithCompletion {
    private func _nop() { }
    
    func perform(command: AnimationCommand, on animatable: Animatable, using sheet: AnimationSheet?) {
        self.perform(command: command, on: animatable, using: sheet, complete: _nop)
    }
    
    func by(_ event: Event) -> AnimationPerformer {
        return AnimationPerformerInitiatedWrapper(withPerformer: self, event: event)
    }
}
