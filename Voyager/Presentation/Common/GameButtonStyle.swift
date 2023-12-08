//
//  GameButtonStyle.swift
//  Voyager
//
//  Created by mnats on 05.12.2023.
//

import SwiftUI

struct GameButtonModifier: ViewModifier {
    var backgroundColor: Color
    var width: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(12)
            .foregroundStyle(.white)
            .font(.system(size: 18).monospaced().weight(.bold))
            .frame(width: width)
            .background(backgroundColor)
            .border(Color.black, width: 2)
    }
}

extension View {
    func gameButtonStyle(_ backgroundColor: Color, width: CGFloat = UIScreen.main.bounds.width * 0.9) -> some View {
        self.modifier(GameButtonModifier(backgroundColor: backgroundColor, width: width))
    }
}
