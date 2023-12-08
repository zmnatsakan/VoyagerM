//
//  WheelView.swift
//  Voyager
//
//  Created by admin on 20.11.2023.
//

import SwiftUI

struct WheelView: View {
    @EnvironmentObject var wheelViewModel: WheelViewModel
    var body: some View {
        ZStack {
            switch wheelViewModel.sceneState {
            case .setup:
                WheelSetupView()
            case .game:
                WheelGameView()
            case .result:
                WheelResultView()
            }
        }.environmentObject(wheelViewModel)
    }
}

//#Preview {
//    WheelView().environmentObject(WheelViewModel())
//}


struct WheelSetupView: View {
    @EnvironmentObject var wheelViewModel: WheelViewModel
    var body: some View {
        VStack {
            HStack {
                ForEach(RWSetupType.allCases, id: \.self) { item in
                    Button(action: {
                        wheelViewModel.selectType = item
                        if wheelViewModel.selectType == .byColor {
                            wheelViewModel.numSelect = nil
                        }
                        if wheelViewModel.selectType == .byNum {
                            wheelViewModel.colorSelect = nil
                        }
                    }, label: {
                        Text(item.rawValue)
                    }).background(wheelViewModel.selectType == item ? Color.green : Color.white)
                }
            }
            if wheelViewModel.selectType == .byBoth || wheelViewModel.selectType == .byColor {
                HStack {
                    ForEach(RWColor.allCases, id: \.self) { item in
                        Button(action: {
                            wheelViewModel.colorSelect = item
                        }, label: {
                            Text(item.rawValue)
                        }).background(wheelViewModel.colorSelect == item ? Color.green : Color.white)
                    }
                }
            }
            if wheelViewModel.selectType == .byBoth || wheelViewModel.selectType == .byNum {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(wheelViewModel.wheelData, id: \.id) { item in
                            Button(action: {
                                wheelViewModel.numSelect = item.num
                            }, label: {
                                Text("\(item.num)")
                            }).background(wheelViewModel.numSelect == item.num ? Color.green : Color.white)
                        }
                    }

                }
            }
            Button(action: {
                wheelViewModel.setGameScene()
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
    
    }
}

struct WheelGameView: View {
    @EnvironmentObject var wheelViewModel: WheelViewModel
//    @State private var gameState: GameState = .start
    @State private var isGame = false
    @State var gameResult = ""
    var body: some View {
        VStack {
            Text(gameResult)
            Image(systemName: "triangleshape.fill").rotationEffect(.degrees(180))
            Image("roulette_wheel")
                .resizable()
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(wheelViewModel.angle))
//            if !isGame {
                Button(action: {
                    isGame = true
                    if #available(iOS 17.0, *) {
                        withAnimation(.easeOut(duration: wheelViewModel.timeRemaining)) {
                            wheelViewModel.angle = Double.random(in: 900.0...3000.0)
                        }
                    completion: {
                        let finishAngle = wheelViewModel.angle / 360.0
                        let remains = finishAngle.truncatingRemainder(dividingBy: 1.0)
                        let resultAngle = remains * 360.0
                        let result = wheelViewModel.getRW(result: resultAngle)
                        gameResult = "\(result.num) \(result.color)"
                        print(result)
                    }
                    } else {
                        withAnimation(.easeOut(duration: wheelViewModel.timeRemaining)) {
                            wheelViewModel.angle = Double.random(in: 900.0...3000.0)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + wheelViewModel.timeRemaining) {
                            let finishAngle = wheelViewModel.angle / 360.0
                            let remains = finishAngle.truncatingRemainder(dividingBy: 1.0)
                            let resultAngle = remains * 360.0
                            let result = wheelViewModel.getRW(result: resultAngle)
                            gameResult = "\(result.num) \(result.color)"
                            print(result)
                        }
                    }
                }, label: {
                    Text("start wheel")
                })
                Button(action: {
                    wheelViewModel.angle = 0.0
                }, label: {
                    Text("reset")
                })
//            }

        }
    }
    
    private enum GameState {
        case start, game, finish
    }
}

struct WheelResultView: View {
    @EnvironmentObject var wheelViewModel: WheelViewModel
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
