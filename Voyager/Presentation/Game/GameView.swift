//
//  GameView.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @StateObject private var currentStageState = NavRouter<CurrentStageState>(route: StorageManager.shared.currentStageState)
    
    var body: some View {
        ZStack {
            Group {
//                switch currentStageState.route {
//                case .stage1:
//                    Stage1View()
//                        .environmentObject(ViewModelFactory.shared.makeStage1ViewModel())
//                case .stage2:
//                    Stage2View()
//                        .environmentObject(ViewModelFactory.shared.makeStage2ViewModel())
//                case .stage3:
                    Stage3View()
                        .environmentObject(ViewModelFactory.shared.makeStage3ViewModel())
//                case .stage4:
//                    Stage4View()
//                        .environmentObject(ViewModelFactory.shared.makeStage4ViewModel())
//                default:
//                    Stage5View()
//                        .environmentObject(ViewModelFactory.shared.makeStage5ViewModel())
//                }
            }
            .environmentObject(currentStageState)
            .environmentObject(appRouter)
        }
    }
}
