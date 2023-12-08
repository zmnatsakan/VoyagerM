//
//  CommonReferences.swift
//  Voyager
//
//  Created by admin on 28.11.2023.
//

import Foundation

struct CommonReferences {
    static let shared = CommonReferences()
    private init() {}
    
    private let food0Text = "Эй, дистрофик, эй, дружок! Ты купи в ларьке пирог!"
    private let food1Text = "Тебе нужен хлебушек, сладкий хлеб, братишка!"
    private let food2Text = "Бог риска и азарта, твоя смертная оболочка ослабла, пора подкрепиться!"
    private let food3Text = "Твое топливо на исходе, не пора ли заправиться?"
    private let food4Text = "Ты совсем завис на чилле, тебе больше не осилить, надо подкрепиться, надо-надо подкрепиться!"
    
    var foodPhraseRandom: String {
        let list = [food0Text, food1Text, food2Text, food3Text, food4Text].shuffled()
        return list.randomElement() ?? food0Text
    }
}

protocol PhraseDelegate {
    var phrases: [PhraseData] { get }
}
