//
//  ContentView.swift
//  MyMemorize
//
//  Created by Devansh Rastogi on 27/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var CardCount: Int = 4
    let theme1 : Array<String> = ["✈️", "🚗", "🚀", "🚙", "🚎", "🚛", "🏎", "🛫", "🚕", "🚐", "⛴", "🚝", "🚟"]
    
    var body: some View {
        VStack {
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
                    CardView(content: theme1[index])
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover
        }
    }

    var cardAdder: some View {
        cardCountAdjust(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardRemover: some View {
        cardCountAdjust(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }

    func cardCountAdjust(by offset: Int, symbol: String) -> some View {
        Button (action: {
            CardCount += offset
        }, label: {
            Image(systemName: symbol)
                .imageScale(.large)
                .font(.largeTitle)
        })
        .disabled(CardCount + offset < 1 || CardCount + offset > theme1.count)
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
        }.foregroundColor(.orange)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
