//
//  ContentView.swift
//  GoofyMemory
//
//  Created by Vítor Nascimento on 30/12/2020.
//

import SwiftUI
import Combine

struct ContentView: View {

    @ObservedObject var viewModel: GoofyMemoryGame

    var body: some View {
        Grid(items: viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(4)
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame.Card

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: GameFactory.createMemoryGame())
    }
}
