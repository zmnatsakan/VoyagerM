//
//  AppRouter.swift
//  Voyager
//
//  Created by admin on 27.11.2023.
//

import SwiftUI

struct AppRouter: View {
    @StateObject private var appNavRouter = NavRouter<AppRouteState>(route: StorageManager.shared.onboardingPresented ? .main : .onboarding)
    
    var body: some View {
        ZStack {
            
                Color.red.ignoresSafeArea(.all)
        
            Group {
                
                switch appNavRouter.route {
                case .onboarding:
                    Button(action: {
                        appNavRouter.push(route: .main)
                        StorageManager.shared.toggleOnboarding()
                    }, label: {
                        Text("skip onboarding")
                    })
                case .game:
                    GameView()
                        .environmentObject(appNavRouter)
                case .info:
                    Text("info")
                case .settings:
                    Text("settings")
                default:
                    MainView()
                        .environmentObject(ViewModelFactory.shared.makeMainViewModel())
                        .environmentObject(appNavRouter)
                        .transition(.move(edge: .trailing))
                }
            }
//            .transition(.scale)
        }
        
    }
}

enum AppRouteState: NavHost {
    case onboarding
    case main
    case game
    case info
    case settings
}
enum GameStageState: String, NavHost {
    case preview
    case game1
    case game2
    case game3
    case game4
    case freePlay
}

enum CurrentStageState: String, NavHost {
    case stage1
    case stage2
    case stage3
    case stage4
    case stage5
}
