//
//  ViewModelFactory.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import Foundation

final class ViewModelFactory {
    static let shared = ViewModelFactory()
    private init() {}
    
    let appController = ApplicationController()
    
    func makeMainViewModel() -> MainViewModel {
        return MainViewModel(appController: appController)
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        return SettingsViewModel(appController: appController)
    }
    
    func makeInfoViewModel() -> InfoViewModel {
        return InfoViewModel()
    }
    
    func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }
    
    func makeGameWheelViewModel() -> WheelViewModel {
        return WheelViewModel()
    }
    
    func makeGameWheelComplicatedViewModel() -> WheelComplicatedViewModel {
        return WheelComplicatedViewModel()
    }
    
    func makeStage1ViewModel() -> Stage1ViewModel {
        return Stage1ViewModel(appController: appController)
    }
    
    func makeStage2ViewModel() -> Stage2ViewModel {
        return Stage2ViewModel(appController: appController)
    }
    
    func makeStage3ViewModel() -> Stage3ViewModel {
        return Stage3ViewModel(appController: appController)
    }
    
    func makeStage4ViewModel() -> Stage4ViewModel {
        return Stage4ViewModel(appController: appController)
    }
    
    func makeStage5ViewModel() -> Stage5ViewModel {
        return Stage5ViewModel(appController: appController)
    }
    
//    func makeStage1ViewModel()
}
