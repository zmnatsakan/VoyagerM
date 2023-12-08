//
//  TwentyOneView.swift
//  dices
//
//  Created by mnats on 21.11.2023.
//

import SwiftUI

struct TwentyOneView: View {
    
    @Namespace private var animation
    @ObservedObject var viewModel: TwentyOneViewModel
    @State var infoPresent = false
    @State var bet = 0
    
    var completion: () -> Void = {}
    
    init(enemyTarget: Int = 20, guaranteedWin: Bool = false, completion: @escaping () -> Void = {}) {
        self.viewModel = TwentyOneViewModel(enemyTarget: enemyTarget, guaranteedWin: guaranteedWin)
        self.completion = completion
    }
    
    @ViewBuilder func initialView() -> some View {
        VStack {
            Spacer()
            Text("Сколько ставишь?")
                .gameButtonStyle(.textBack)
            ForEach([100, 250, 500], id: \.self) { amount in
                Button {
                    bet = amount
                    Task {
                        await viewModel.startGame()
                    }
                } label: {
                    Text(amount.description)
                        .gameButtonStyle(.nextButton)
                }
            }
        }
        .padding(.bottom, 30)
        .frame(height: 400)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func gameView() -> some View {
        VStack {
            Spacer()
            HStack {
                ForEach(CardRank.allCases.sorted(by: { $0.rawValue < $1.rawValue }), id: \.rawValue) { rank in
                    let card = Card(rank, of: .spades)
                    VStack {
                        CardView(card: card)
                            .padding(.horizontal, -CGFloat(1.3 * Double(CardRank.allCases.count)))
                            .onAppear {
                                card.isClosed = false
                            }
                        Text(card.rank.rawValue.description)
                            .foregroundStyle(.white)
                            .font(.monospaced(.headline)().bold())
                            .shadow(radius: 2)
                    }
                }
            }
            .gameButtonStyle(.textBack)
            .opacity(infoPresent ? 1 : 0)
            
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        infoPresent.toggle()
                    }
                } label: {
                    Text(infoPresent ? "X" : "?")
                        .gameButtonStyle(.textBack, width: 50)
                }
                .padding()
            }
            
            HStack {
                deckView()
                    .frame(width: 100)
                Spacer()
                VStack(alignment: .leading) {
                    enemyHandView()
                        .frame(height: 100)
                    playerHandView()
                        .frame(height: 100)
                }
            }
            .disabled(viewModel.isFinished)
            comparisonButton()
        }
        .frame(height: 400)
    }
    
    @ViewBuilder func resultView() -> some View {
        VStack {
            Spacer()
            Group {
                if viewModel.gameResult == .win {
                    Text("+\(bet)")
                } else if viewModel.gameResult == .lose {
                    Text("-\(bet)")
                } else {
                    Text("Ничья!")
                }
                Text("Сыграем еще?")
            }
                .gameButtonStyle(.textBack)
            Button {
                Task {
                    viewModel.resetGame()
                }
            } label: {
                Text("Да")
                    .gameButtonStyle(.nextButton)
            }
            Button {
                completion()
            } label: {
                Text("Нет")
                    .gameButtonStyle(.nextButton)
            }
        }
        .padding(.bottom, 30)
        .frame(height: 400)
        .frame(maxWidth: .infinity)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            if !viewModel.isFinishPresented {
                if viewModel.deck.isEmpty {
                    initialView()
                } else {
                    gameView()
                }
            } else {
                resultView()
            }
        }
        .background {
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        Rectangle()
                            .frame(height: 5)
                        Rectangle()
                            .foregroundStyle(Color(red: 0.13, green: 0.14, blue: 0.19))
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                    }
                }.ignoresSafeArea()
            }
    }

    private func deckView() -> some View {
        HStack {
            Spacer()
            ZStack(alignment: .center) {
                CardView(card: Card(.eight, of: .clubs))
                ForEach(viewModel.deck, id: \.id) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.dealToPlayer()
                        }
                        .matchedGeometryEffect(id: card.id, in: animation)
                        .disabled(!viewModel.isEnemyDealt)
                }
            }
            Spacer()
        }
    }

    private func enemyHandView() -> some View {
        VStack {
            HStack {            
                if let enemyScore = viewModel.enemyScore {
                    if viewModel.isFinished {
                        Text("\(enemyScore)")
                            .foregroundStyle(.white)
                            .font(.monospaced(.headline)().bold())
                            .padding(.trailing, 15)
                    }
                }
                ForEach(viewModel.enemyHand, id: \.id) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: animation)
                        .padding(.horizontal, -CGFloat(3 * viewModel.enemyHand.count))
                        .onAppear {
                            card.isClosed = true
                        }
                }
            }
            .padding(.horizontal, 50)
        }
    }

    private func playerScoreView() -> some View {
        Text("\(viewModel.playerScore)")
            .foregroundStyle(.white)
            .font(.monospaced(.headline)().bold())
            .padding(.trailing, 15)
    }

    private func playerHandView() -> some View {
        VStack {
            HStack {
                if viewModel.playerScore > 0 && viewModel.isFinished {
                    playerScoreView()
                }
                ForEach(viewModel.hand, id: \.id) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: animation)
                        .padding(.horizontal, -CGFloat(3 * viewModel.hand.count))
                }
            }
            .padding(.horizontal, 50)
        }
    }

    private func comparisonButton() -> some View {
        return Button {
            viewModel.compareHands()
        } label: {
            Text("Compare")
                .gameButtonStyle(.nextButton)
        }
            .opacity(viewModel.playerScore == 0 || viewModel.isFinished ? 0 : 1)
            .disabled(viewModel.playerScore == 0)
            .padding(.bottom, 100)
    }
}

#Preview {
    TwentyOneView(guaranteedWin: true)
}
