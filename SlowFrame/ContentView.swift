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
    @State private var inputFrames = [UIImage?]()
    @State private var frame = 0
    @State private var playing = false


    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            HStack {
                Button("Select image") {
                    showingImagePicker = true
                }
            }
            Button(playing ? "Stop" : "Play") {
                print("Play button pressed")
                if playing { playing = false } else {
                    playing = true
                    playTimeLapse()
                    
                }
            }
        }
        .onChange(of: inputFrames) { _ in processFrames()}
        .onChange(of: frame) {_ in playTimeLapse()}
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage, inputFrames: $inputFrames)
        }
        
    
    }
    
    func processFrames() {
        print("Processing frames")
        if inputFrames.isEmpty {return}
        frames.removeAll()
        for inputFrame in inputFrames {
            let newFrame = Image(uiImage: inputFrame!)
            frames.append(newFrame)
        }
        print("Frames converted")
        print(frames.count)
        print(frames)
        image = frames[0]
    }
    
        

    func loadImage() {
        guard let inputImage = inputImage else {return}
        let newFrame = Image(uiImage: inputImage)
        frames.append(newFrame)
        print("FRames")
        print(frames)
        print("inputFrames")
        print(inputFrames)

        
    }
    
    func playTimeLapse() {
        if playing {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("In delay")
            frame += 1
            image = frames[frame]
            if frame >= frames.count - 1 {frame = 0}
        }
        
    }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
