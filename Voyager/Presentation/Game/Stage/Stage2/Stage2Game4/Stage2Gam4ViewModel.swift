import Combine

final class Stage2Gam4ViewModel: ObservableObject {
    @Published var state: Stage2GameState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage2BetReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    
    enum Stage2GameState {
        case text0, text1, text2, text3, text4,  text5, text6, game
    }
    
    func nextText(_ state: Stage2GameState) {
        if index < Stage2BetReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage2BetReference.shared.phrases[index]
        }
    }
}
