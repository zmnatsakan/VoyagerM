import SwiftUI
import Foundation

final class SlotMashineViewModel: ObservableObject {
    
    @Published private(set) var _gameStatus: GameStatus = .chooseDepositSize
    
    @Published var depositeSize = 30
    
    @Published var spinCount = 0
    
    @Published var imageOffset: CGFloat = 0
    
     var betAmount = 5
    
     var symbols = ["slot1", "slot2", "slot3","slot4", "slot5", "slot6", "slot7", "slot8", "slot9"]
    
    @Published var numbers = [1, 2, 0, 5, 4, 3, 8, 7, 6]
    
    func setChooseDepositteSize() {
        _gameStatus = .chooseDepositSize
    } 
    func setPlaying() {
        _gameStatus = .playing
    }
    func setResult() {
        _gameStatus = .result
    }
    
    
    func startSlotAnimation() {
        let maxSpins = 10
        var spins = 0
        
        spinCount += 1

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [self] timer in
            spins += 1
            self.imageOffset = 0
            withAnimation(.linear(duration: 0.2)) {
                self.imageOffset = 100
            }
            numbers[0] = Int.random(in: 0..<symbols.count - 1)
            numbers[1] = Int.random(in: 0..<symbols.count - 1)
            numbers[2] = Int.random(in: 0..<symbols.count - 1)
            
            numbers[3] = Int.random(in: 0..<symbols.count - 1)
            numbers[4] = Int.random(in: 0..<symbols.count - 1)
            numbers[5] = Int.random(in: 0..<symbols.count - 1)
            
            numbers[6] = Int.random(in: 0..<symbols.count - 1)
            numbers[7] = Int.random(in: 0..<symbols.count - 1)
            numbers[8] = Int.random(in: 0..<symbols.count - 1)
            
            if spins >= maxSpins {
                timer.invalidate()
                
                self.imageOffset = 0
                 var winCon = Int.random(in: 0...8)
                
                if spinCount % 4 == 0 {
                    numbers[0] = winCon
                    numbers[4] = winCon
                    numbers[8] = winCon
                    
                        showResult()
                } else {
                    showResult()
                }
               

            }
            
        }
    }
    
    
    func showResult() {
        
        if numbers[0] == numbers[1] && numbers[1] == numbers[2] {
            depositeSize -= betAmount
            depositeSize += betAmount * 6
        }
        
         else if numbers[3] == numbers[4] && numbers[4] == numbers[5] {
            depositeSize -= betAmount
            depositeSize += betAmount * 6
        }
    
        else if numbers[6] == numbers[7] && numbers[7] == numbers[8] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else if numbers[0] == numbers[3] && numbers[3] == numbers[6] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else if numbers[1] == numbers[4] && numbers[4] == numbers[7] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else if numbers[2] == numbers[5] && numbers[5] == numbers[8] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else if numbers[0] == numbers[4] && numbers[4] == numbers[8] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else if numbers[2] == numbers[4] && numbers[4] == numbers[6] {
           depositeSize -= betAmount
           depositeSize += betAmount * 6
       }
        
        else {
            depositeSize -= betAmount
        }
        
        if depositeSize == 0 {
            setResult()
        }
    }
    
    enum GameStatus {
        case chooseDepositSize
        case playing
        case result
    }
    
}
