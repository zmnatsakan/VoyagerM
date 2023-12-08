import SwiftUI

struct Stage5Game4View: View {
    
    @EnvironmentObject var stage5ViewModel: Stage5ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @StateObject var stage5Game4ViewModel = Stage5Game4ViewModel()
    
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .ignoresSafeArea(.all)
            Image(stage5Game4ViewModel.phraseSource.type.imageName)
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
            
            switch stage5Game4ViewModel.state {
            case .text0:
                stageView {
                    stage5Game4ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage5Game4ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage5Game4ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage5Game4ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage5Game4ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage5Game4ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage5Game4ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage5Game4ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage5Game4ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage5Game4ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage5Game4ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage5Game4ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage5Game4ViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    stage5Game4ViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    stage5Game4ViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    stage5Game4ViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    stage5Game4ViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    stage5Game4ViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
                    stage5Game4ViewModel.nextText(.text19)
                }
            case .text19:
                stageView {
                    stage5Game4ViewModel.nextText(.text20)
                }
            case .text20:
                stageView {
                    stage5Game4ViewModel.nextText(.text21)
                }
            case .text21:
                stageView {
                    stage5Game4ViewModel.nextText(.game)
                }
            case .game:
                stageView {
                    
                }
            }
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage5Game4ViewModel.textOutput)
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
                    .opacity(stage5Game4ViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage5Game4ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage5Game4ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage5Game4ViewModel.phraseSource.text {
            stage5Game4ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: 20_000_000)
            }
        }
        stage5Game4ViewModel.printingFinished.toggle()
    }
    
}
