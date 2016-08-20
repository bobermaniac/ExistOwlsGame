//
//  Actor.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 13/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

public protocol ActionProcessing : class {
    func actionReceived(_ action: Action, from actor: Actor)
}

public protocol ActionFiltering {
    func satisfiesCondition(action: Action) -> Bool
}

public protocol EventConsuming {
    func process(event: Event) -> [Action]?
}

public class ActionRouter {
    private struct ActionRouterItem {
        public let processor : ActionProcessing
        public let filter : ActionFiltering?
        
        public init(processor: ActionProcessing, filter: ActionFiltering?) {
            self.processor = processor
            self.filter = filter
        }
        
        public func process(_ action: Action, from actor: Actor) {
            guard filter == nil || filter!.satisfiesCondition(action: action) else {
                return
            }
            processor.actionReceived(action, from: actor)
        }
    }
    
    private var subscribers : [ActionRouterItem] = []
    private unowned var actor : Actor
    
    public init(actor : Actor) {
        self.actor = actor
    }
    
    public func addSubscriber(subscriber: ActionProcessing, filter : ActionFiltering? = nil) {
        subscribers.append(ActionRouterItem(processor: subscriber, filter: filter))
    }
    
    public func removeSubscriber(subscriber : ActionProcessing) {
        subscribers = subscribers.filter { $0.processor !== subscriber }
    }
    
    public func process(action : Action) {
        subscribers.forEach{ $0.process(action, from: actor) }
    }
}

public class Actor : EventConsuming {
    public func process(event: Event) -> [Action]? {
        return nil
    }
}
