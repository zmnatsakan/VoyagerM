//
//  WheelComplicatedViewModel.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import Combine
import SwiftUI

final class WheelComplicatedViewModel: ObservableObject {
    
    @Published private(set) var sceneState: WheelComplicatedSceneState = .setup
    
    // MARK: - game scene values
    @Published var timeRemaining: TimeInterval = 10
    @Published var wheelAngle = 0.0
    @Published var ballAngle = 0.0
    let wheelSector = 360.0 / 37.0
    
    func setGameScene() {
        sceneState = .game
    }
    
    func setResultScene() {
        sceneState = .result
    }
    
    var wheelData: [RWCData] {
        return [
            RWCData(color: .black, num: 26, sector: .init(start: 0.0, end: wheelSector)),
            RWCData(color: .red, num: 3, sector: .init(start: wheelSector, end: wheelSector * 2)),
            RWCData(color: .black, num: 35, sector: .init(start: wheelSector * 2, end: wheelSector * 3)),
            RWCData(color: .red, num: 12, sector: .init(start: wheelSector * 3, end: wheelSector * 4)),
            RWCData(color: .black, num: 28, sector: .init(start: wheelSector * 4, end: wheelSector * 5)),
            RWCData(color: .red, num: 7, sector: .init(start: wheelSector * 5, end: wheelSector * 6)),
            RWCData(color: .black, num: 29, sector: .init(start: wheelSector * 6, end: wheelSector * 7)),
            RWCData(color: .red, num: 18, sector: .init(start: wheelSector * 7, end: wheelSector * 8)),
            RWCData(color: .black, num: 22, sector: .init(start: wheelSector * 8, end: wheelSector * 9)),
            RWCData(color: .red, num: 9, sector: .init(start: wheelSector * 9, end: wheelSector * 10)),
            RWCData(color: .black, num: 31, sector: .init(start: wheelSector * 10, end: wheelSector * 11)),
            RWCData(color: .red, num: 14, sector: .init(start: wheelSector * 11, end: wheelSector * 12)),
            RWCData(color: .black, num: 20, sector: .init(start: wheelSector * 12, end: wheelSector * 13)),
            RWCData(color: .red, num: 1, sector: .init(start: wheelSector * 13, end: wheelSector * 14)),
            RWCData(color: .black, num: 33, sector: .init(start: wheelSector * 14, end: wheelSector * 15)),
            RWCData(color: .red, num: 16, sector: .init(start: wheelSector * 15, end: wheelSector * 16)),
            RWCData(color: .black, num: 24, sector: .init(start: wheelSector * 16, end: wheelSector * 17)),
            RWCData(color: .red, num: 5, sector: .init(start: wheelSector * 17, end: wheelSector * 18)),
            RWCData(color: .black, num: 10, sector: .init(start: wheelSector * 18, end: wheelSector * 19)),
            RWCData(color: .red, num: 23, sector: .init(start: wheelSector * 19, end: wheelSector * 20)),
            RWCData(color: .black, num: 8, sector: .init(start: wheelSector * 20, end: wheelSector * 21)),
            RWCData(color: .red, num: 30, sector: .init(start: wheelSector * 21, end: wheelSector * 22)),
            RWCData(color: .black, num: 11, sector: .init(start: wheelSector * 22, end: wheelSector * 23)),
            RWCData(color: .red, num: 36, sector: .init(start: wheelSector * 23, end: wheelSector * 24)),
            RWCData(color: .black, num: 13, sector: .init(start: wheelSector * 24, end: wheelSector * 25)),
            RWCData(color: .red, num: 27, sector: .init(start: wheelSector * 25, end: wheelSector * 26)),
            RWCData(color: .black, num: 6, sector: .init(start: wheelSector * 26, end: wheelSector * 27)),
            RWCData(color: .red, num: 34, sector: .init(start: wheelSector * 27, end: wheelSector * 28)),
            RWCData(color: .black, num: 17, sector: .init(start: wheelSector * 28, end: wheelSector * 29)),
            RWCData(color: .red, num: 25, sector: .init(start: wheelSector * 29, end: wheelSector * 30)),
            RWCData(color: .black, num: 2, sector: .init(start: wheelSector * 30, end: wheelSector * 31)),
            RWCData(color: .red, num: 21, sector: .init(start: wheelSector * 31, end: wheelSector * 32)),
            RWCData(color: .black, num: 4, sector: .init(start: wheelSector * 32, end: wheelSector * 33)),
            RWCData(color: .red, num: 19, sector: .init(start: wheelSector * 33, end: wheelSector * 34)),
            RWCData(color: .black, num: 15, sector: .init(start: wheelSector * 34, end: wheelSector * 35)),
            RWCData(color: .red, num: 32, sector: .init(start: wheelSector * 35, end: wheelSector * 36)),
            RWCData(color: .green, num: 0, sector: .init(start: wheelSector * 36, end: wheelSector * 37))
        ]
    }
    
    func getRWC(result: Double) -> RWCData {
        return wheelData.filter({ result > $0.sector.start && result < $0.sector.end }).first ?? .init(color: .red, num: 0, sector: .init(start: 0.0, end: 0.0))
    }
    
    func calculateAngle(_ angle: Double, isBall: Bool = false) -> Double {
        let newAngle = (isBall ? (angle * -1) : angle) / 360.0
        let remains = newAngle.truncatingRemainder(dividingBy: 1.0)
        return (isBall ? 1.0 - remains : remains) * 360.0
    }
    
    struct RWCData: Identifiable {
        let id = UUID()
        let color: RWCColor
        let num: Int
        let sector: RWCSector
    }

    struct RWCSector {
        let start: Double
        let end: Double
    }
    
    enum WheelComplicatedSceneState: CaseIterable {
        case setup
        case game
        case result
    }
}

enum RWCColor: String, CaseIterable {
    case red, black, green
}

enum RWCSetupType: String, CaseIterable {
    case byColor
    case byNum
    case byBoth
}
