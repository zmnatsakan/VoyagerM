import Combine

final class Stage5Game1ViewModel:  ObservableObject {
    
    @Published var state: Stage5GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage5OptionsReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    enum Stage5GameState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9, text10, game
    }
    
    func nextText(_ state: Stage5GameState) {
        if index < Stage5OptionsReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage5OptionsReference.shared.phrases[index]
        }
    }
}
