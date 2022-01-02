//
//  ImagePicker.swift
//  SlowFrame
//
//  Created by Petar Simonovic on 29/12/2021.


import Foundation

import PhotosUI
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
        
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print("Here!")
            // Tell the picker to go away
            picker.dismiss(animated: true)

            // Exit if no selection was made
            if results.isEmpty { return }

            // If this has an image we can use, use it
            for result in results {
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parent.inputFrames.append(image as! UIImage)
                }
            }
            }
        }
        
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }
    
    @Binding var inputFrames: [UIImage?]

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        print("Returning picker")
        print(picker)
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    

    
    
    typealias UIViewControllerType = PHPickerViewController

}
