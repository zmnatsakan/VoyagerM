//
//  Stage3Game1ViewModel.swift
//  Voyager
//
//  Created by mnats on 01.12.2023.
//

import Combine

final class Stage3Game1ViewModel: ObservableObject {
    @Published var state: Stage3GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage3HippodromeReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage3GameState {
        case text0, text1, text2, text3, text4, text5, game
    }
    
    func nextText(_ state: Stage3GameState) {
        if index < Stage3HippodromeReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage3HippodromeReference.shared.phrases[index]
        }
    }
}
