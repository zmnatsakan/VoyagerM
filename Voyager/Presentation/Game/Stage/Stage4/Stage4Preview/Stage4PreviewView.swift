//
//  Stage4PreviewView.swift
//  Voyager
//
//  Created by mnats on 04.12.2023.
//

import SwiftUI

struct Stage4PreviewView: View {
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @StateObject var stage4PreviewViewModel = Stage4PreviewViewModel()
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .ignoresSafeArea(.all)
            Image(stage4PreviewViewModel.phraseSource.type.imageName)
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
            switch stage4PreviewViewModel.state {
            case .text0:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text1)
                }
            case .text1:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text2)
                }
            case .text2:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text3)
                }
            case .text3:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text4)
                }
            case .text4:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text5)
                }
            case .text5:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text6)
                }
            case .text6:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text7)
                }
            case .text7:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text8)
                }
            case .text8:
                stageView(src: stage4PreviewViewModel.phraseSource.text) {
                    stage4PreviewViewModel.nextText(.text9)
                }
            case .text9:
                stageViewWithAnswers {
                    stage4ViewModel.setState(.game1)
                } negativeAction: {
                    stage4ViewModel.setState(.game1)
                }

                
            }
        }
    }
    
    @ViewBuilder private func stageView(src: String, nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage4PreviewViewModel.textOutput)
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
            }, label: {
                Text("Дальше")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage4PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage4PreviewViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage4PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    @ViewBuilder private func stageViewWithAnswers(customText: String? = nil, positiveAction: @escaping () -> Void, negativeAction: @escaping () -> Void) -> some View {
        VStack {
            Text(customText ?? stage4PreviewViewModel.textOutput)
                .padding(12)
                .foregroundStyle(.white)
                .font(.system(size: 14).monospaced().weight(.bold))
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(Color(.textBack))
                .border(Color.black, width: 2)
                .padding(.bottom, 2)
            
            Button(action: {
                positiveAction()
            }, label: {
                Text(stage4PreviewViewModel.phraseSource.answerPositive ?? "")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage4PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage4PreviewViewModel.printingFinished)
            .padding(.bottom, 2)
            
            Button(action: {
                negativeAction()
            }, label: {
                Text(stage4PreviewViewModel.phraseSource.answerNegative ?? "")
                    .padding(12)
                    .foregroundStyle(.white)
                    .opacity(stage4PreviewViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage4PreviewViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage4PreviewViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage4PreviewViewModel.phraseSource.text {
            stage4PreviewViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: 5_000_000)
//                try await Task.sleep(nanoseconds: 20_000_000)
            }
        }
        stage4PreviewViewModel.printingFinished.toggle()
    }
}


#Preview {
    Stage4PreviewView()
}

