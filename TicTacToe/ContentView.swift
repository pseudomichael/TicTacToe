//
//  ContentView.swift
//  TicTacToe
//
//  Created by Michael Edwards on 10/24/21.
//  Thanks to Jared Davidson sample project:
//  https://github.com/Archetapp/TickityTacTow
//

import SwiftUI

struct ContentView: View {
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver = false
    
    func buttonAction(_ index: Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .x)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .bold()
                .foregroundColor(.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            ForEach(0 ..< 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {
                            self.buttonAction(index)
                        })
                    })
                }
            })
        }
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Game Over"), message: Text(self.ticTacToeModel.gameOver.0 == .x ? "You won!" : self.ticTacToeModel.gameOver.0 == .o ? "Computer won!" : "No one won!"), dismissButton: Alert.Button.destructive(Text("OK"), action: {
                self.ticTacToeModel.resetGame()
            }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
