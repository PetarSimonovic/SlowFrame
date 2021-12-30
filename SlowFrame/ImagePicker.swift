//
//  ImagePicker.swift
//  SlowFrame
//
//  Created by Petar Simonovic on 29/12/2021.


import Foundation

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    
    typealias UIViewControllerType = PHPickerViewController

    
}
