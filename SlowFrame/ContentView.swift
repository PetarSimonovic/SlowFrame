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
    @State private var speed: Double = 0.5
    @State private var imagePickerResult: Int = 0
   



    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            HStack {
                Button("Add images") {
                    showingImagePicker = true
                }
                Button("Reset") {
                    inputFrames.removeAll()
                    frames.removeAll()
                    playing = false
                }
            }
            Button(playing ? "Stop" : "Preview") {
                print("Play button pressed")
                if playing { playing = false } else {
                    playing = true
                    playTimeLapsePreview()
                    
                }
            }
            VStack {
                Slider(
                          value: $speed,
                          in: 0...5
                    )
                Text("\(speed)")
                Button("Create Timelapse") {
                    print("Creating timelapse")
                    let timelapseCreator = TimelapseCreator(speed: speed, inputFrames: inputFrames)
                    print(timelapseCreator.build())
                    
                }

            }
            
                    }
        .onChange(of: inputFrames) { _ in processPreviewFrames()}
        .onChange(of: frame) {_ in playTimeLapsePreview()}
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(inputFrames: $inputFrames, imagePickerResult: $imagePickerResult)
        }
        
    
    }
    
    func processPreviewFrames() {
        print("Not ready to process")
        if inputFrames.isEmpty || inputFrames.count < imagePickerResult  {return}
        print("Processing frames")
        frames.removeAll()
        var previewFrames = 0
        if inputFrames.count < 30 {
            previewFrames = inputFrames.count
            
        } else
        { previewFrames = 30
        }
        for inputFrame in 0 ... previewFrames  {
            let newFrame = Image(uiImage: inputFrames[inputFrame]!)
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
    
    func playTimeLapsePreview() {
        if playing {
        DispatchQueue.main.asyncAfter(deadline: .now() + speed) {
            print("In delay")
            frame += 1
            image = frames[frame]
            if frame >= frames.count - 1 || frame >= 30 {frame = 0}
        }
        
    }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
