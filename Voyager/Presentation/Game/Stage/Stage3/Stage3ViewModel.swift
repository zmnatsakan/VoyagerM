//
//  Stage3ViewModel.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import Combine
import Foundation

final class Stage3ViewModel: ObservableObject {
    
    let appController: ApplicationController
    
    init(appController: ApplicationController) {
        self.appController = appController
    }
    
    @Published var stageState = StorageManager.shared.stage3State
    
    func setState(_ state: GameStageState) {
        DispatchQueue.main.async {
            StorageManager.shared.setStage3State(state)
            self.stageState = StorageManager.shared.stage3State
        }
    }
}
