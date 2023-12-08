//
//  Stage3PreviewViewModel.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import Combine

final class Stage4PreviewViewModel: ObservableObject {
    @Published var state: Stage4PreviewState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage4PreviewReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    enum Stage4PreviewState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9
    }
    
    func nextText(_ state: Stage4PreviewState) {
        if index < Stage4PreviewReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage4PreviewReference.shared.phrases[index]
        }
    }
}

