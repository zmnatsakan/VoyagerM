import Combine

final class Stage2PreviewViewModel: ObservableObject {
    @Published var state: Stage2PrviewState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage2PreviewReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    
    
    enum Stage2PrviewState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9, text10
    }
    
    
    func nextText(_ state: Stage2PrviewState) {
        if index < Stage2PreviewReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage2PreviewReference.shared.phrases[index]
        }
    }
    
}
