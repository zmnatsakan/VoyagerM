import Combine

final class Stage5PreviewViewModel: ObservableObject {
    
    @Published var state: Stage5PreviewState = .text0
    @Published var textOutput = ""
    @Published var phraseSource = Stage5PreviewReference.shared.phrases[0]
    @Published var printingFinished = false
    @Published var index = 0
    
    @Published var crossPut = false
    
    
    enum Stage5PreviewState {
        case text0, text1, text2, text3, text4, text5, text6, text7, text8, text9
    }
    
    func nextText(_ state: Stage5PreviewState) {
        if index < Stage5PreviewReference.shared.phrases.count - 1 {
            self.state = state
            index += 1
            textOutput = ""
            phraseSource = Stage5PreviewReference.shared.phrases[index]
        }
    }
    
}
