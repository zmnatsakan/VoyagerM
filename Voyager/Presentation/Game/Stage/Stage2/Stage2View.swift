//
//  Stage2View.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct Stage2View: View {
    @EnvironmentObject var stageViewModel: Stage2ViewModel
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    
    @StateObject private var stage2Router = NavRouter<GameStageState>(route: StorageManager.shared.stage2State)
    var body: some View {
        ZStack {
            switch stageViewModel.stageState {
            case .preview:
                Stage2PreviewView()
            case .game1:
                Stage2Game1View()
            case .game2:
                Stage2Game2View()
            case .game3:
                Stage2Game3View()
            case .game4:
                Stage2Game4View()
            case .freePlay:
                Stage2FreePlayView()
                    .environmentObject(currentStageState)
            }
        }
        .environmentObject(stageViewModel)
    }
}

struct Stage2FreePlayView: View {
    @EnvironmentObject var currentStageState: NavRouter<CurrentStageState>
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    var body: some View {
        VStack {
            Text("free play")
            Button(action: {
                currentStageState.push(route: .stage3)
                StorageManager.shared.setCurrentStage(.stage3)
            }, label: {
                Text("stage 3")
            })
        }
    }
}
