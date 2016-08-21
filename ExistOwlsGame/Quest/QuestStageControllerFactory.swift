//
//  QuestStageControllerFactory.swift
//  ExistOwlsGame
//
//  Created by Victor Bryksin on 21/08/16.
//  Copyright © 2016 Victor Bryksin. All rights reserved.
//

import Foundation

struct QuestStagePresenterFactory : StagePresenterFactory {
    func createStagePresenter() -> StagePresenter {
        return ExampleQuestScene(fileNamed: "ExampleQuestScene")!
    }
}

struct QuestStageControllerFactory : StageControllerFactory {
    func createStageController() -> StageController {
        return StageController(withStagePresenterFactory: QuestStagePresenterFactory())
    }
}
