//
//  ContentView.swift
//  SlowFrame
//
//  Created by Petar Simonovic on 29/12/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        image = Image("Example")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
