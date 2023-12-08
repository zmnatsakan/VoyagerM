//
//  MainViewModel.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import Combine

final class MainViewModel: ObservableObject {
    
    let appController: ApplicationController
    
    init(appController: ApplicationController) {
        self.appController = appController
    }
}
