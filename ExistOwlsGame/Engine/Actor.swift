//
//  Actor.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 13/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

protocol ActionProcessing : class {
    func actionReceived(_ action: Action, from actor: StageActor)
}

protocol ActionFiltering {
    func satisfiesCondition(action: Action) -> Bool
}

protocol EventConsuming {
    func process(event: Event) -> [Action]?
}

class ActionRouter {
    private struct ActionRouterItem {
        public let processor : ActionProcessing
        public let filter : ActionFiltering?
        
        public init(processor: ActionProcessing, filter: ActionFiltering?) {
            self.processor = processor
            self.filter = filter
        }
        
        public func process(_ action: Action, from actor: StageActor) {
            guard filter == nil || filter!.satisfiesCondition(action: action) else {
                return
            }
            processor.actionReceived(action, from: actor)
        }
    }
    
    private var subscribers : [ ActionRouterItem ] = []
    private unowned var actor : StageActor
    
    public init(actor : StageActor) {
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

protocol StageActorPresenter : class {
    weak var controller : StageActor? { get set }
}

protocol StageActorPresenterFactory {
    func createActorPresenter() -> StageActorPresenter
}

class StageActor : EventConsuming {
    private(set) lazy var presenter : StageActorPresenter? = {
        let presenter = self.presenterFactory.createActorPresenter()
        presenter.controller = self
        return presenter
    }();
    
    init(withPresenterFactory presenterFactory: StageActorPresenterFactory) {
        self.presenterFactory = presenterFactory
    }
    
    // MARK: state
    
    weak var stateObserver: StageActorStateObserver? = nil
    
    var state : State = .None {
        didSet {
            stateObserver?.actorDidChangeState(self, to: state)
        }
    }
    
    // MARK: events
    
    public func process(event: Event) -> [Action]? {
        return nil
    }
    
    // MARK: private variables
    let presenterFactory : StageActorPresenterFactory
}
