//
//  ContentView.swift
//  MyMemorize
//
//  Created by Devansh Rastogi on 27/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var CardCount: Int = 3
    @State var CurrentTheme: Int = 0
    
    let theme = [["✈️", "🚗", "🚀", "🚙", "🚎", "🚛", "🏎", "🛫", "🚕", "🚐", "⛴", "🚝", "🚟"],
                 ["🐱", "🐈", "🐈‍⬛", "🐶", "🐕‍🦺", "🐰", "🐇", "🐭", "🐹", "🐀", "🦔", "🐮", "🐷"],
                 ["📷", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "💽", "💾", "💿", "🎙"]]
    let themeSymbol = ["car.circle.fill",
                       "heart.circle.fill",
                       "camera.circle.fill"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            cards
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 120))]) {
                ForEach(0..<CardCount, id: \.self) { index in
                    CardView(content: theme[CurrentTheme][index])
                }
            }
        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            themeButtons
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var themeButtons: some View {
        HStack {
            ForEach(0..<theme.count, id: \.self) { index in
                themeAdjust(to: index, symbol: themeSymbol[index])
            }
        }
    }

    var cardAdder: some View {
        cardCountAdjust(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardRemover: some View {
        cardCountAdjust(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    func themeAdjust(to: Int, symbol: String) -> some View {
        Button(action: {
            CurrentTheme = to
        }, label: {
            Image(systemName: symbol)
        })
        .opacity((CurrentTheme == to) ? 1 : 0.3)
    }

    func cardCountAdjust(by offset: Int, symbol: String) -> some View {
        Button (action: {
            CardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(CardCount + offset < 1 || CardCount + offset > theme[CurrentTheme].count)
    }
}

struct CardView: View {
    @State var isFaceUp = true
    let content: String
    
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
        .foregroundColor(.orange)
        .aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
