//
//  CardView.swift
//  dices
//
//  Created by mnats on 21.11.2023.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var card: Card = Card(.six, of: .spades)
    
    var rankLabel: String {
        switch card.rank {
        case .six:
            "6"
        case .seven:
            "7"
        case .eight:
            "8"
        case .nine:
            "9"
        case .ten:
            "10"
        case .jack:
            "J"
        case .queen:
            "Q"
        case .king:
            "K"
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(card.isClosed ? Color(red: 0.7, green: 0.1, blue: 0.1) : .white)
                .frame(width: 50, height: 75)
                .shadow(color: card.isClosed ? .black : Color(red: 0.7, green: 0.1, blue: 0.1), radius: 2)
            if !card.isClosed {
                Text(rankLabel)
                    .font(.title3.bold())
                    .foregroundStyle(card.suit == .clubs || card.suit == .spades ? .black : .red)
                    .padding(5)
            }
        }
        .overlay {
            if !card.isClosed {
                Text(card.suit.rawValue)
                    .font(.title2)
            }
        }
        .transition(.scale(scale: 1))
        .rotation3DEffect(.degrees(card.isClosed ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

#Preview {
    VStack {
        let card = Card(.eight, of: .clubs)
        CardView(card: card)
        Button("Turn") {
            withAnimation {
                card.isClosed.toggle()
            }
        }
    }
}
