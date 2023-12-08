//
//  Stage1PreviewView.swift
//  Voyager
//
//  Created by admin on 01.12.2023.
//

import SwiftUI

struct Stage1PreviewView: View {
    @StateObject var stage1PreviewViewModel = Stage1PreviewViewModel()
    @EnvironmentObject var stage1ViewModel: Stage1ViewModel
    @EnvironmentObject var appRouter: NavRouter<AppRouteState>
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .ignoresSafeArea(.all)
            Image("casinoPartner")
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
                Group {
                    VStack {
                        Text(stage1PreviewViewModel.textOutput)
                            .padding(12)
                            .foregroundStyle(.white)
                            .font(.system(size: 14).monospaced().weight(.bold))
                            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .topLeading)
                            .multilineTextAlignment(.leading)
                            .background(Color(.textBack))
                            .border(Color.black, width: 2)
                            .padding(.bottom, 2)
                        
                        Button(action: {
                            stage1ViewModel.setState(.game1)
                        }, label: {
                            Text("Дальше")
                                .padding(12)
                                .foregroundStyle(.white)
                                .opacity(stage1PreviewViewModel.printingFinished ? 0.3 : 1.0)
                                .font(.system(size: 18).monospaced().weight(.bold))
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .background(Color(.nextButton))
                                .border(Color.black, width: 2)
                        })
                        .disabled(stage1PreviewViewModel.printingFinished)
                        .padding(.bottom)
                        
                        
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
                }.onAppear {
                    stage1PreviewViewModel.printingFinished.toggle()
                    Task {
                        try await writeTextBySymbols()
                    }
                    
                }
            
        }
    }
    
    func writeTextBySymbols() async throws {
        for char in stage1PreviewViewModel.phraseSource.text {
            stage1PreviewViewModel.textOutput += String(char)
            if char != " " {
                try await Task.sleep(nanoseconds: 20_000_000)
            }
        }
        stage1PreviewViewModel.printingFinished.toggle()
    }
}
