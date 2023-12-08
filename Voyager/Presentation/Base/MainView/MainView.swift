//
//  MainView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI
import UIPilot

struct MainView: View {
//    @EnvironmentObject var pilot: UIPilot<String>
    @EnvironmentObject var mainViewModel: MainViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var body: some View {
        VStack {
            Button(action: {
                appRouter.push(route: .game)
                
            }, label: {
                Text("Game")
            })
            Button(action: {
                appRouter.push(route: .info)
            }, label: {
                Text("info")
            })
            Button(action: {
                StorageManager.shared.setStage1State(.preview)
                StorageManager.shared.setStage2State(.preview)
                StorageManager.shared.setStage3State(.preview)
                StorageManager.shared.setStage4State(.preview)
                StorageManager.shared.setStage5State(.preview)
                StorageManager.shared.setCurrentStage(.stage1)
            }, label: {
                Text("reset")
            })
        }
    }
}

//#Preview {
//    MainView()
//}
