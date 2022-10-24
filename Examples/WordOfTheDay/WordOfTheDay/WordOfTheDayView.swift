//
//  ContentView.swift
//  WordOfTheDay
//
//  Created by Pablo Ezequiel Romero Giovannoni on 08/10/2022.
//

import SwiftUI

struct WordOfTheDayView: View {
    let theme: Theme
    @StateObject var viewModel: WordOfTheDayViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .fill(theme.mainColor)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let title = viewModel.title {
                    Text(title)
                        .font(.title)
                }
                Text(viewModel.word)
                    .padding()
                Button("Start", action: { viewModel.refresh() })
                    .buttonStyle(.bordered)

            }
            .foregroundColor(theme.accentColor)
        }
    }
}

struct WordOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        WordOfTheDayView(
            theme: .init(),
            viewModel: .init()
        )
    }
}
