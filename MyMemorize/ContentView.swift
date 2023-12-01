//
//  ContentView.swift
//  MyMemorize
//
//  Created by Devansh Rastogi on 27/11/23.
//

import SwiftUI

struct ContentView: View {
    let minPairs: Int = 4
    let defTheme: Int = 0               //default theme
    @State var currentPairs: Int = 4
    @State var CardCount: Int = 8       //current card count
    @State var CurrentTheme: Int = 0
    
    //deletable in future
    @State var minCardCount: Int = 8
    
    let theme = [["✈️", "🚗", "🚀", "🚙", "🚎", "🚛", "🏎", "🛫", "🚕", "🚐", "⛴", "🚝", "🚟"],
                 ["🐱", "🐈", "🐈‍⬛", "🐶", "🐕‍🦺", "🐰", "🐇", "🐭", "🐹", "🐀", "🦔", "🐮", "🐷"],
                 ["📷", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "💽", "💾", "💿", "🎙"]]
    let themeSymbol: Array<String> = ["car.circle",
                                      "leaf.circle",
                                      "camera.circle"]
    let themeDescription = ["Vehicles",
                            "Animals",
                            "eDevices"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            resetButton
            cards
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        let shuffledTheme = theme[CurrentTheme].shuffled()
        let shuffledThemeUpto = shuffledTheme.prefix(currentPairs)
        let bufferShuffledTheme = shuffledThemeUpto + shuffledThemeUpto
        let finalShuffledTheme = bufferShuffledTheme.shuffled()
        
        return ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 100))]) {
                ForEach(0..<(currentPairs*2), id: \.self) { index in
                    CardView(content: finalShuffledTheme[index])
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
    }
    
    var themeButtons: some View {
        HStack {
            ForEach(0..<theme.count, id: \.self) { index in
                themeAdjust(to: index, describe: themeDescription[index] , symbol: themeSymbol[index])
            }
        }
    }

    var cardAdder: some View {
        cardCountAdjust(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardRemover: some View {
        cardCountAdjust(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    var resetButton: some View {
        return Button(action: {
//            CardCount = minCardCount
            currentPairs = minPairs
            CurrentTheme = defTheme
        }, label: {
            VStack {
                Text("Reset")
            }
        }).disabled((currentPairs == minPairs) && (CurrentTheme == defTheme))
    }
    
    func themeAdjust(to theme: Int, describe: String, symbol: String) -> some View {
        return Button(action: {
            CurrentTheme = theme
            currentPairs = Int.random(in: minPairs...13)
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                Text(describe)
                    .font(.footnote)
            }
        })
        .opacity((CurrentTheme == theme) ? 1 : 0.5)
    }

    func cardCountAdjust(by offset: Int, symbol: String) -> some View {
        Button (action: {
//            CardCount += offset
            currentPairs += offset
        }, label: {
            Image(systemName: symbol)
                .imageScale(.large)
        })
        .disabled(currentPairs + offset < 1 || currentPairs + offset > theme[CurrentTheme].count)
    }
}

struct CardView: View {
    @State var isFaceUp = false
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
