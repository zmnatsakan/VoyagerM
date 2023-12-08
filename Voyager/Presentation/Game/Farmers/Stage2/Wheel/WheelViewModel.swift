//
//  WheelViewModel.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import Combine
import SwiftUI

final class WheelViewModel: ObservableObject {
    
    @Published private(set) var sceneState: WheelSceneState = .setup
    
    func setGameScene() {
        sceneState = .game
    }
    
    func setResultScene() {
        sceneState = .result
    }
    
    // MARK: game scene values
    @Published var timeRemaining: TimeInterval = 10
    @Published var angle = 0.0
    let rouletteSector = 360.0 / 37.0
    
    // MARK: - setup scene values
    
    @Published var colorSelect: RWColor? = nil
    @Published var numSelect: Int? = nil
    @Published var selectType: RWSetupType = .byBoth
    @Published var amount: Int = 0
    
    // MARK: - result scene values
    
    var wheelData: [RWData] {
        return [
            RWData(color: .black, num: 26, sector: .init(start: 0.0, end: rouletteSector)),
            RWData(color: .red, num: 3, sector: .init(start: rouletteSector, end: rouletteSector * 2)),
            RWData(color: .black, num: 35, sector: .init(start: rouletteSector * 2, end: rouletteSector * 3)),
            RWData(color: .red, num: 12, sector: .init(start: rouletteSector * 3, end: rouletteSector * 4)),
            RWData(color: .black, num: 28, sector: .init(start: rouletteSector * 4, end: rouletteSector * 5)),
            RWData(color: .red, num: 7, sector: .init(start: rouletteSector * 5, end: rouletteSector * 6)),
            RWData(color: .black, num: 29, sector: .init(start: rouletteSector * 6, end: rouletteSector * 7)),
            RWData(color: .red, num: 18, sector: .init(start: rouletteSector * 7, end: rouletteSector * 8)),
            RWData(color: .black, num: 22, sector: .init(start: rouletteSector * 8, end: rouletteSector * 9)),
            RWData(color: .red, num: 9, sector: .init(start: rouletteSector * 9, end: rouletteSector * 10)),
            RWData(color: .black, num: 31, sector: .init(start: rouletteSector * 10, end: rouletteSector * 11)),
            RWData(color: .red, num: 14, sector: .init(start: rouletteSector * 11, end: rouletteSector * 12)),
            RWData(color: .black, num: 20, sector: .init(start: rouletteSector * 12, end: rouletteSector * 13)),
            RWData(color: .red, num: 1, sector: .init(start: rouletteSector * 13, end: rouletteSector * 14)),
            RWData(color: .black, num: 33, sector: .init(start: rouletteSector * 14, end: rouletteSector * 15)),
            RWData(color: .red, num: 16, sector: .init(start: rouletteSector * 15, end: rouletteSector * 16)),
            RWData(color: .black, num: 24, sector: .init(start: rouletteSector * 16, end: rouletteSector * 17)),
            RWData(color: .red, num: 5, sector: .init(start: rouletteSector * 17, end: rouletteSector * 18)),
            RWData(color: .black, num: 10, sector: .init(start: rouletteSector * 18, end: rouletteSector * 19)),
            RWData(color: .red, num: 23, sector: .init(start: rouletteSector * 19, end: rouletteSector * 20)),
            RWData(color: .black, num: 8, sector: .init(start: rouletteSector * 20, end: rouletteSector * 21)),
            RWData(color: .red, num: 30, sector: .init(start: rouletteSector * 21, end: rouletteSector * 22)),
            RWData(color: .black, num: 11, sector: .init(start: rouletteSector * 22, end: rouletteSector * 23)),
            RWData(color: .red, num: 36, sector: .init(start: rouletteSector * 23, end: rouletteSector * 24)),
            RWData(color: .black, num: 13, sector: .init(start: rouletteSector * 24, end: rouletteSector * 25)),
            RWData(color: .red, num: 27, sector: .init(start: rouletteSector * 25, end: rouletteSector * 26)),
            RWData(color: .black, num: 6, sector: .init(start: rouletteSector * 26, end: rouletteSector * 27)),
            RWData(color: .red, num: 34, sector: .init(start: rouletteSector * 27, end: rouletteSector * 28)),
            RWData(color: .black, num: 17, sector: .init(start: rouletteSector * 28, end: rouletteSector * 29)),
            RWData(color: .red, num: 25, sector: .init(start: rouletteSector * 29, end: rouletteSector * 30)),
            RWData(color: .black, num: 2, sector: .init(start: rouletteSector * 30, end: rouletteSector * 31)),
            RWData(color: .red, num: 21, sector: .init(start: rouletteSector * 31, end: rouletteSector * 32)),
            RWData(color: .black, num: 4, sector: .init(start: rouletteSector * 32, end: rouletteSector * 33)),
            RWData(color: .red, num: 19, sector: .init(start: rouletteSector * 33, end: rouletteSector * 34)),
            RWData(color: .black, num: 15, sector: .init(start: rouletteSector * 34, end: rouletteSector * 35)),
            RWData(color: .red, num: 32, sector: .init(start: rouletteSector * 35, end: rouletteSector * 36)),
            RWData(color: .green, num: 0, sector: .init(start: rouletteSector * 36, end: rouletteSector * 37))
        ]
    }
    
    
    func getRW(result: Double) -> RWData {
        return wheelData.filter({ result > $0.sector.start && result < $0.sector.end }).first ?? .init(color: .red, num: 0, sector: .init(start: 0.0, end: 0.0))
    }
    
    
    struct RWData: Identifiable {
        let id = UUID()
        let color: RWColor
        let num: Int
        let sector: RWSector
    }

    struct RWSector {
        let start: Double
        let end: Double
    }


    enum WheelSceneState: CaseIterable {
        case setup
        case game
        case result
    }

}

enum RWColor: String, CaseIterable {
    case red, black, green
}

enum RWSetupType: String, CaseIterable {
    case byColor
    case byNum
    case byBoth
}
