//
//  ContentView.swift
//  SlowFrame
//
//  Created by Petar Simonovic on 29/12/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var frames = [Image]()
    @State private var frame = 0


    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select image") {
                showingImagePicker = true
            }
            Button("Cycle images") {
                changeImage()
            }
        }
        .onChange(of: inputImage) { _ in loadImage()}
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    
    }
        

    func loadImage() {
        guard let inputImage = inputImage else {return}
        let newFrame = Image(uiImage: inputImage)
        frames.append(newFrame)
        
    }
    
    func changeImage() {
        if frames.isEmpty { return }
        image = frames[frame]
        frame += 1
        if frame >= frames.count {
            frame = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
