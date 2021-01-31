//
//  ContentView.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import SwiftUI
import Combine

struct GameView: View {

    @ObservedObject var viewModel: GoofyMemoryGame

    var body: some View {
        VStack {
            Text(viewModel.theme.name)
            HStack {
                Spacer()
                Text("\(viewModel.score)")
                    .padding(.horizontal, 16)
            }
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(4)
            }
            .padding()
            .foregroundColor(.init(viewModel.theme.cardColor))
            .font(.largeTitle)
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    var card: StringMemoryGame.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .transition(.opacity)
                Text(card.content)
                    .foregroundColor(.black)
                    .transition(.scale)
            } else {
                if !card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill()
                    .transition(.identity)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameFactory.createMemoryGame())
    }
}
