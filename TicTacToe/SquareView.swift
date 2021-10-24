//
//  SquareView.swift
//  TicTacToe
//
//  Created by Michael Edwards on 10/24/21.
//  Thanks to Jared Davidson sample project:
//  https://github.com/Archetapp/TickityTacTow
//

import SwiftUI

enum SquareStatus {
    case x
    case o
    case empty
}

class Square: ObservableObject {
    @Published var squareStatus: SquareStatus
    
    init(squareStatus: SquareStatus) {
        self.squareStatus = squareStatus
    }
}

struct SquareView: View {
    @ObservedObject var dataSource: Square
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(self.dataSource.squareStatus == .x ? "X" : self.dataSource.squareStatus == .o ? "O" : " ")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(width: 70, height: 70, alignment: .center)
                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .padding(4)
        })
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(dataSource: Square(squareStatus: .x), action: {})
    }
}
