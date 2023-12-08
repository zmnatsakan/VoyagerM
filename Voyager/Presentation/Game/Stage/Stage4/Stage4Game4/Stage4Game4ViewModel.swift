//
//  Stage3Game2ViewModel.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import Combine

final class Stage4Game4ViewModel: ObservableObject {
    @Published var state: Stage4GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage4BettingWColleaguesReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage4GameState {
        case text0, text1, text2, text3, text4, text5, text6, game
    }
    
    func nextText(_ state: Stage4GameState) {
        if index < Stage4BettingWColleaguesReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage4BettingWColleaguesReference.shared.phrases[index]
        }
    }
}
