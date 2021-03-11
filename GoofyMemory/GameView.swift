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
                    withAnimation(.linear) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(4)
            }
            .padding()
            .foregroundColor(.init(viewModel.theme.cardColor))
            .font(.largeTitle)
            Button(action: {
                withAnimation(.easeInOut) {
                    viewModel.newGame()
                }
            }, label: {
                Text("New Game")
            })
        }
    }
}

struct CardView: View {
    var card: StringMemoryGame.Card

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @State var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-animatedBonusRemaining*360-90), clockwise: true)
                    } else {
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding()
                .opacity(0.4)
                .onAppear() {
                    startBonusTimeAnimation()
                }
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardfiy(isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameFactory.createMemoryGame(theme: .halloween)
        game.choose(card: game.cards[0])
        return GameView(viewModel: game)
    }
}
