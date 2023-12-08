import SwiftUI

struct Stage2Game1View: View {
    @EnvironmentObject var stage2ViewModel: Stage2ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    @StateObject var stage2Game1ViewModel = Stage2Game1ViewModel()
    
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .ignoresSafeArea(.all)
            Image(stage2Game1ViewModel.phraseSource.type.imageName)
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
            switch stage2Game1ViewModel.state {
            case .text0:
                stageView {
                    stage2Game1ViewModel.nextText(.text1)
                }
            case .text1:
                stageView {
                    stage2Game1ViewModel.nextText(.text2)
                }
            case .text2:
                stageView {
                    stage2Game1ViewModel.nextText(.text3)
                }
            case .text3:
                stageView {
                    stage2Game1ViewModel.nextText(.text4)
                }
            case .text4:
                stageView {
                    stage2Game1ViewModel.nextText(.text5)
                }
            case .text5:
                stageView {
                    stage2Game1ViewModel.nextText(.text6)
                }
            case .text6:
                stageView {
                    stage2Game1ViewModel.nextText(.text7)
                }
            case .text7:
                stageView {
                    stage2Game1ViewModel.nextText(.text8)
                }
            case .text8:
                stageView {
                    stage2Game1ViewModel.nextText(.text9)
                }
            case .text9:
                stageView {
                    stage2Game1ViewModel.nextText(.text10)
                }
            case .text10:
                stageView {
                    stage2Game1ViewModel.nextText(.text11)
                }
            case .text11:
                stageView {
                    stage2Game1ViewModel.nextText(.text12)
                }
            case .text12:
                stageView {
                    stage2Game1ViewModel.nextText(.text13)
                }
            case .text13:
                stageView {
                    stage2Game1ViewModel.nextText(.text14)
                }
            case .text14:
                stageView {
                    stage2Game1ViewModel.nextText(.text15)
                }
            case .text15:
                stageView {
                    stage2Game1ViewModel.nextText(.text16)
                }
            case .text16:
                stageView {
                    stage2Game1ViewModel.nextText(.text17)
                }
            case .text17:
                stageView {
                    stage2Game1ViewModel.nextText(.text18)
                }
            case .text18:
                stageView {
                    stage2Game1ViewModel.nextText(.text19)
                }
            case .text19:
                stageView {
//                    stage2Game1ViewModel.nextText(.game)
                    stage2ViewModel.setState(.game2)
                }
            case .game:
                stageView {
                    
                }
            }
        }
    }
    
    @ViewBuilder private func stageView(nextState: @escaping () -> Void) -> some View {
        VStack {
            Text(stage2Game1ViewModel.textOutput)
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
                    .opacity(stage2Game1ViewModel.printingFinished ? 0.3 : 1.0)
                    .font(.system(size: 18).monospaced().weight(.bold))
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(Color(.nextButton))
                    .border(Color.black, width: 2)
            })
            .disabled(stage2Game1ViewModel.printingFinished)
            .padding(.bottom)
            
            
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .onAppear {
                stage2Game1ViewModel.printingFinished.toggle()
                Task {
                    try await writeTextBySymbols()
                }
                
            }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage2Game1ViewModel.phraseSource.text {
            stage2Game1ViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: 1_000_000)
            }
        }
        stage2Game1ViewModel.printingFinished.toggle()
    }
    
}
