//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Michael Edwards on 10/24/21.
//  Thanks to Jared Davidson sample project:
//  https://github.com/Archetapp/TickityTacTow
//

import Foundation
import SwiftUI

class TicTacToeModel: ObservableObject {
    @Published var squares = [Square]()
    
    init() {
        for _ in 0...8 {
            squares.append(Square(squareStatus: .empty))
        }
    }
    
    var gameOver: (SquareStatus, Bool) {
        get {
            if thereIsAWinner != .empty {
                return (thereIsAWinner, true)
            } else {
                for i in 0...8 {
                    if squares[i].squareStatus == .empty {
                        return (.empty, false)
                    }
                }
                return (.empty, true)
            }
        }
    }
    
    private var thereIsAWinner: SquareStatus {
        get {
            if let check = self.checkIndexes([0, 1, 2]) {
                return check
            } else if let check = self.checkIndexes([3, 4, 5]) {
                return check
            } else if let check = self.checkIndexes([6, 7, 8]) {
                return check
            } else if let check = self.checkIndexes([0, 3, 6]) {
                return check
            } else if let check = self.checkIndexes([1, 4, 7]) {
                return check
            } else if let check = self.checkIndexes([2, 5, 8]) {
                return check
            } else if let check = self.checkIndexes([0, 4, 8]) {
                return check
            } else if let check = self.checkIndexes([2, 4, 6]) {
                return check
            }
            
            return .empty
        }
    }
    
    func resetGame() {
        for i in 0...8 {
            squares[i].squareStatus = .empty
        }
    }
    
    private func checkIndexes(_ indexes: [Int]) -> SquareStatus? {
        var xCounter = 0
        var oCounter = 0
        
        for i in indexes {
            let square = squares[i]
            if square.squareStatus == .x {
                xCounter += 1
            } else if square.squareStatus == .o {
                oCounter += 1
            }
        }
        
        if xCounter == 3 {
            return .x
        } else if oCounter == 3 {
            return .o
        }
        
        return nil
    }
    
    private func moveAI() {
        var index = Int.random(in: 0...8)
        while makeMove(index: index, player: .o) == false && gameOver.1 == false {
            index = Int.random(in: 0...8)
        }
    }
    
    func makeMove(index: Int, player: SquareStatus) -> Bool {
        if squares[index].squareStatus == .empty {
            squares[index].squareStatus = player
            if player == .x {
                moveAI()
            }
            return true
        }
        return false
    }
}
