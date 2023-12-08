//
//  Stage1PreviewViewModel.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import Combine

final class Stage1PreviewViewModel: ObservableObject {
    @Published var textOutput = ""
    @Published var phraseSource = Stage1PreviewReference.shared.phrases[0]
    @Published var printingFinished = false
}

