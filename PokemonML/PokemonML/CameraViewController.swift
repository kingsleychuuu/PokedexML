//
//  CameraViewController.swift
//  PokemonML
//
//  Created by admin on 2020-04-28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var captureSession = AVCaptureSession()
    var previewView = CameraView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        configureCamera()
        setupCameraView()
    }
    
    func configureCamera() {
        // Open Capture Session Configuration
        captureSession.beginConfiguration()
        
        // Setup Camera Devices
        let videoDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .unspecified)
        
        // Check that the video device input is usable by the capture session
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!), captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        // Photo Output Setup
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        
        // Set output to handle wide angle output
        captureSession.sessionPreset = .hd1920x1080
        captureSession.addOutput(photoOutput)
        
        // Close Capture Session Configuration
        captureSession.commitConfiguration()
        
        // Set Preview
        previewView.videoPreviewLayer.session = self.captureSession
        captureSession.startRunning()
    }
    

    private func setupCameraView() {
            // Sets up the CameraView to fill entire screen
            previewView.frame = self.view.frame
            self.view.addSubview(previewView)
            setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(capturePhoto))
        tap.delegate = self
        previewView.addGestureRecognizer(tap)
    }
    
    @objc func capturePhoto() {
        if let output = captureSession.outputs.first as? AVCapturePhotoOutput {
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .off
            output.capturePhoto(with: settings, delegate: self)
        }
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation() {
            let capturedImage = UIImage(data: data)!
            if let parent = self.parent as? ViewController {
                parent.updateImage(image: capturedImage)
            }
        }
    }
}
