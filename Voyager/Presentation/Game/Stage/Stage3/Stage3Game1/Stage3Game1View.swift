//
//  Stage1Game1View.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage3Game1View: View {
    @EnvironmentObject var stage3ViewModel: Stage3ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @StateObject var stage3Game1ViewModel = Stage3Game1ViewModel()
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .ignoresSafeArea(.all)
            Image(stage3Game1ViewModel.phraseSource.type.imageName)
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            VStack {
                HStack {
                    Button(action: {
                        appRouter.pop()
                    }, label: {
                        Image("backArrow")
                            .resizable()
                            .frame(width: 12, height: 20)
                            .padding()
                    })
                    Spacer()
                }
                Spacer()
            }
            switch stage3Game1ViewModel.state {
            case .text0:
                stageView {
                    stage3Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage3Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage3Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage3Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage3Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage3ViewModel.setState(.game2)
                }
            case .game:
                stageView {
                    stage3ViewModel.setState(.game2)
                }
            }
            
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage3Game1ViewModel.textOutput)
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: 14).monospaced().weight(.bold))
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(Color(.textBack))
                .border(Color.black, width: 2)
                .padding(.bottom, 2)
            
            Button(action: {
                nextState()
                //                stage1ViewModel.setState(.game1)
            }, label: {
                Text("Дальше")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage3Game1ViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage3Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage3Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage3Game1ViewModel.phraseSource.text {
            stage3Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: 20_000_000)
            }
        }
        stage3Game1ViewModel.printingFinished.toggle()
    }
    
}

