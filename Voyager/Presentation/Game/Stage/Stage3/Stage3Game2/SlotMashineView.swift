//
//  SlotMashineView.swift
//  SPR
//
//  Created by admin on 11/21/23.
//

import SwiftUI

struct SlotMashineView: View {
    
    @EnvironmentObject var stage4ViewModel: Stage4ViewModel
    @EnvironmentObject var slotMashineViewModel: SlotMashineViewModel

    
    var body: some View {
            
            VStack {
                switch slotMashineViewModel._gameStatus {
                case .chooseDepositSize:
                    chooseDepositeView()
                case .playing:
                    playingView()
                case .result:
                    resultView()
                }
            }
        
        
    }
    
    
    
    @ViewBuilder private func chooseDepositeView() -> some View {
        VStack {
            
            Spacer()
            
            Text("Сколько ставим-с?")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: 280)
                .background(Color.mint.opacity(1))
                .border(Color.black, width: 2)
        
            chooseDepositeSizeButton(1000)
            
            chooseDepositeSizeButton(2500)
            
            chooseDepositeSizeButton(4000)

            chooseDepositeSizeButton(5000)
                .padding(.bottom, 32)
        }
        .frame(maxWidth: .infinity)
            .background {
                        ZStack {
                            VStack(spacing: 0) {
                                Spacer()
                                Rectangle()
                                    .frame(height: 5)
                                Rectangle()
                                    .foregroundStyle(Color(red: 0.13, green: 0.14, blue: 0.19))
                                    .frame(height: UIScreen.main.bounds.height * 0.5)
                            }
                        }.ignoresSafeArea()
                    }
    }
    
    @ViewBuilder private func chooseDepositeSizeButton(_ size: Int) -> some View {
        Button(action: {
            slotMashineViewModel.depositeSize = size
            slotMashineViewModel.setPlaying()
        }, label: {
        Text("\(size)")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: 280)
                .background(Color.orange.opacity(1))
                .border(Color.black, width: 2)
        })
    }
    
    
    @ViewBuilder private func imageSpinRowView(_ a: Int, _ b: Int, _ c: Int) -> some View {
        HStack(spacing: 0) {
            Spacer()
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[a]])
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[b]])
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            
            Image(slotMashineViewModel.symbols[slotMashineViewModel.numbers[c]])
                .resizable()
                .aspectRatio(1, contentMode: .fit )
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .frame(width: 100, height: 100)
            Spacer()
        }
    }
    
    
    
    @ViewBuilder private func playingView() -> some View {
        VStack {
            
            Spacer()
            
            HStack {
                Button(action: {
                    slotMashineViewModel.setResult()
                }, label: {
                    Text("X")
                        .padding(.leading, 22)
                    
                    Spacer()
                })
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                ZStack {
                    imageSpinRowView(0, 1, 2)
                    imageSpinRowView(1, 3, 4)
                        .offset(y: -100)
                }
                .offset(y: slotMashineViewModel.imageOffset)
                imageSpinRowView(3, 4, 5)
                    .offset(y: slotMashineViewModel.imageOffset)
                imageSpinRowView(1, 3, 4)
                    .offset(y: slotMashineViewModel.imageOffset)
            }
            .clipShape(.rect)
            Spacer()
            
            Button(action: {
                slotMashineViewModel.startSlotAnimation()
            }, label: {
                Text("Крутим!!")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 280)
                    .background(Color.orange.opacity(1))
                    .border(Color.black, width: 2)
            })
            
            Spacer()
            
        }
        
    }

    
    @ViewBuilder private func resultView() -> some View {
        VStack {
            
            Spacer()
            
            Text("Закончили упражнение.")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: 280)
                .background(Color.mint.opacity(1))
                .border(Color.black, width: 2)
            
            Button(action: {
                slotMashineViewModel.setChooseDepositteSize()
            }, label: {
                Text("Может ещё покрутим?")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 280)
                    .background(Color.orange.opacity(1))
                    .border(Color.black, width: 2)
            })
            
            
            Button(action: {
                stage4ViewModel.setState(.game4)
            }, label: {
                Text("Дальше")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 280)
                    .background(Color.orange.opacity(1))
                    .border(Color.black, width: 2)
            }) .padding(.bottom, 32)
            
            
        }
        .frame(maxWidth: .infinity)
            .background {
                        ZStack {
                            VStack(spacing: 0) {
                                Spacer()
                                Rectangle()
                                    .frame(height: 5)
                                Rectangle()
                                    .foregroundStyle(Color(red: 0.13, green: 0.14, blue: 0.19))
                                    .frame(height: UIScreen.main.bounds.height * 0.5)
                            }
                        }.ignoresSafeArea()
                    }
    }
}

#Preview {
    SlotMashineView().environmentObject(SlotMashineViewModel())
}
