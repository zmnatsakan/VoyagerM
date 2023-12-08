//
//  Stage5View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage5View: View {
    
    @EnvironmentObject var stageViewModel: Stage5ViewModel
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
//    @StateObject var stage5ViewModel = Stage5ViewModel(appController: ApplicationController())
    @StateObject private var stage5Router = NavRouter<GameStageState>(route: StorageManager.shared.stage5State)
    var body: some View {
        ZStack {
            switch stageViewModel.stageState {
            case .preview:
                Stage5PreviewView()
            case .game1:
                Stage5Game1View()
            case .game2:
                Stage5Game2View()
            case .game3:
                Stage5Game3View()
            case .game4:
                Stage5Game4View()
            case .freePlay:
                Stage5FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}




struct Stage5FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    var body: some View {
        VStack {
            Text("free play")
//            Button(action: {
//                currentStageState.push(route: .stage5)
//                StorageManager.shared.setCurrentStage(.stage5)
//            }, label: {
//                Text("stage 5")
//            })
        }
    }
}


