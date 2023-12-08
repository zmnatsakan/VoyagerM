//
//  Stage3View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage3View: View {
    @EnvironmentObject var stageViewModel: Stage3ViewModel
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    @StateObject private var stage3Router = NavRouter<GameStageState>(route: StorageManager.shared.stage3State)
    var body: some View {
        ZStack {
            switch stageViewModel.stageState {
            case .preview:
                Stage3PreviewView()
            case .game1:
                Stage3Game1View()
            case .game2:
                Stage3Game2View()
            case .game3:
                Stage3Game3View()
            case .game4:
                Stage3Game4View()
            case .freePlay:
                Stage3FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}

struct Stage3FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    var body: some View {
        VStack {
            Text("free play")
            Button(action: {
                currentStageState.push(route: .stage4)
                StorageManager.shared.setCurrentStage(.stage4)
            }, label: {
                Text("stage 4")
            })
        }
    }
}
