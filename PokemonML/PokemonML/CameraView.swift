//
//  CameraView.swift
//  PokemonML
//
//  Created by admin on 2020-04-28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView {
    
    // Set the layer class of view to be of type AVCaptureVideoPreviewLayer
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    // Variable to access the preview layer
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

