//
//  Stage.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 21/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import SpriteKit

enum StageEvent {
    case Click(location: vector_float2, actor: StageActorPresenter?)
    case Update(time: TimeInterval)
}

protocol StageEventsInput : class {
    
}

protocol StagePresenter : class {
    weak var eventsOutput : StageEventsInput? { get set }
    weak var controller: StageController? { get set }
    
    func presentStage(on view: SKView)
}

protocol StagePresenterFactory {
    func createStagePresenter() -> StagePresenter
}

class StageController : StageEventsInput {
    private(set) lazy var presenter : StagePresenter? = {
        let presenter = self.stagePresenterFactory.createStagePresenter()
        presenter.controller = self
        return presenter
    }()
    
    private var stagePresenterFactory : StagePresenterFactory
    
    init(withStagePresenterFactory stagePresenterFactory: StagePresenterFactory) {
        self.stagePresenterFactory = stagePresenterFactory
    }
}

protocol StageControllerFactory {
    func createStageController() -> StageController
}
