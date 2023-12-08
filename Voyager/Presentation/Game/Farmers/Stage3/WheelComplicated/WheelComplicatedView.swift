//
//  WheelComplicatedView.swift
//  Voyager
//
//  Created by admin on 23.11.2023.
//

import SwiftUI

struct WheelComplicatedView: View {
    @EnvironmentObject var wheelComplicatedViewModel: WheelComplicatedViewModel
    var body: some View {
        ZStack {
            switch wheelComplicatedViewModel.sceneState {
            case .setup:
                WheelComplicatedSetupView()
            case .game:
                WheelComplicatedGameView()
            case .result:
                WheelComplicatedResultView()
            }
        }
        .environmentObject(wheelComplicatedViewModel)
    }
}

struct WheelComplicatedSetupView: View {
    @EnvironmentObject var wheelComplicatedViewModel: WheelComplicatedViewModel
    var body: some View {
        VStack {
            Button(action: {
                wheelComplicatedViewModel.setGameScene()
            }, label: {
                Text("Button")
            })
        }
    }
}

struct WheelComplicatedGameView: View {
    @EnvironmentObject var wheelComplicatedViewModel: WheelComplicatedViewModel
    @State var gameResult = ""
    var body: some View {
        VStack {
            Text(gameResult)
            ZStack {
                Image("roulette_wheel")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .rotationEffect(.degrees(wheelComplicatedViewModel.wheelAngle))
                Image("roulette_wheel_ball")
                    .resizable()
                    .frame(width: 210, height: 210)
                    .rotationEffect(.degrees(wheelComplicatedViewModel.ballAngle))
            }
            Button(action: {
                if #available(iOS 17.0, *) {
                    withAnimation(.easeOut(duration: wheelComplicatedViewModel.timeRemaining)) {
                        wheelComplicatedViewModel.wheelAngle = Double.random(in: 900.0...3000.0)
                        wheelComplicatedViewModel.ballAngle = -Double.random(in: 900.0...3000.0)
                    } completion: {
                        let wheelResultAngle = wheelComplicatedViewModel.calculateAngle(wheelComplicatedViewModel.wheelAngle)
                        let ballResultAngle = wheelComplicatedViewModel.calculateAngle(wheelComplicatedViewModel.ballAngle, isBall: true)
                        if wheelResultAngle < ballResultAngle {
                            let result = wheelComplicatedViewModel.getRWC(result: wheelResultAngle + (360.0 - ballResultAngle))
                            gameResult = "\(result.num) \(result.color)"
                            
                        } else {
                            let result = wheelComplicatedViewModel.getRWC(result: wheelResultAngle - ballResultAngle)
                            gameResult = "\(result.num) \(result.color)"
                        }
                    }
                } else {
                    withAnimation(.easeOut(duration: wheelComplicatedViewModel.timeRemaining)) {
                        wheelComplicatedViewModel.wheelAngle = Double.random(in: 900.0...3000.0)
                        wheelComplicatedViewModel.ballAngle = -Double.random(in: 900.0...3000.0)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + wheelComplicatedViewModel.timeRemaining) {
                        let wheelResultAngle = wheelComplicatedViewModel.calculateAngle(wheelComplicatedViewModel.wheelAngle)
                        let ballResultAngle = wheelComplicatedViewModel.calculateAngle(wheelComplicatedViewModel.ballAngle, isBall: true)
                        if wheelResultAngle < ballResultAngle {
                            let result = wheelComplicatedViewModel.getRWC(result: wheelResultAngle + (360.0 - ballResultAngle))
                            gameResult = "\(result.num) \(result.color)"
                            
                        } else {
                            let result = wheelComplicatedViewModel.getRWC(result: wheelResultAngle - ballResultAngle)
                            gameResult = "\(result.num) \(result.color)"
                        }
                    }
                }
            }, label: {
                Text("Button")
            })
            Button(action: {
                wheelComplicatedViewModel.wheelAngle = 0.0
                wheelComplicatedViewModel.ballAngle = 0.0
            }, label: {
                Text("reset")
            })
        }
    }
}

struct WheelComplicatedResultView: View {
    @EnvironmentObject var wheelComplicatedViewModel: WheelComplicatedViewModel
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

//#Preview {
//    WheelComplicatedView().environmentObject(WheelComplicatedViewModel())
//}
