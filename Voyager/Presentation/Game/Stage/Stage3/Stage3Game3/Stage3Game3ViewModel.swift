//
//  Stage3Game2ViewModel.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import Combine

final class Stage3Game3ViewModel: ObservableObject {
    @Published var state: Stage3GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage3BetComplicatedReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage3GameState {
        case text0, text1, text2, text3, text4, text5, text6, text7, game
    }
    
    func nextText(_ state: Stage3GameState) {
        if index < Stage3BetComplicatedReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage3BetComplicatedReference.shared.phrases[index]
        }
    }
}
