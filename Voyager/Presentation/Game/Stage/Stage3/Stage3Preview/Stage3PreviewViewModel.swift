//
//  Stage3PreviewViewModel.swift
//  Voyager
//
//  Created by mnats on 01.12.2023.
//

import Combine

final class Stage3PreviewViewModel: ObservableObject {
    @Published var state: Stage3PreviewState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage3PreviewReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    enum Stage3PreviewState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9, text10
    }
    
    func nextText(_ state: Stage3PreviewState) {
        if index < Stage3PreviewReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage3PreviewReference.shared.phrases[index]
        }
    }
}
