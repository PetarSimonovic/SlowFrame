//
//  TimelapseCreator.swift
//  SlowFrame
//
//  Created by Petar Simonovic on 02/01/2022.
//

import Foundation
import AVFoundation
import UIKit
import PhotosUI
import SwiftUI


struct TimelapseCreator {
    
    let speed: Double
    let inputFrames: [UIImage?]

    init(speed: Double, inputFrames: [UIImage?]) {
        self.speed = speed
        self.inputFrames = inputFrames        
    }
    
    func setURL() -> URL {
        let fileManager = FileManager.default
            let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            guard let documentDirectory = urls.first else {
                fatalError("documentDir Error")
            }

            return documentDirectory.appendingPathComponent("\(UUID()).mp4")
    }
    
    func build() {
        
        let outputURL = setURL()
        guard let timelapseWriter = try? AVAssetWriter(outputURL: outputURL, fileType: AVFileType.mp4) else {
                fatalError("AVAssetWriter error")
            }
        
         print(timelapseWriter)

    }
    
    
    
}
