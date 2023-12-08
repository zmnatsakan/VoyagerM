//
//  Stage1ViewModel.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

final class Stage1ViewModel: ObservableObject {
    
    let appController: ApplicationController
    
    init(appController: ApplicationController) {
        self.appController = appController
    }
    
    @Published var stageState = StorageManager.shared.stage1State
    
    func setState(_ state: GameStageState) {
        DispatchQueue.main.async {
            StorageManager.shared.setStage1State(state)
            self.stageState = StorageManager.shared.stage1State
        }
    }
}
