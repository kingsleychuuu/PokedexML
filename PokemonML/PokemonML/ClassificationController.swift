//
//  ClassificationController.swift
//  PokemonML
//
//  Created by admin on 2020-04-30.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision
import ImageIO

protocol ClassificationControllerDelegate {
    func didFinishClassification(_ classification: (String, Float))
}

class ClassificationController {
    let delegate: ClassificationControllerDelegate!
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            // Use the generated swift file from CoreML of Pokemon Classifier
            let model = try VNCoreMLModel(for: PokemonModel().model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to Load Pokemon ML Model: \(error)")
        }
    }()

    init(delegate: ClassificationControllerDelegate) {
        self.delegate = delegate
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        
        DispatchQueue.main.async {
            guard let results = request.results else {
                print("UNABLE TO CLASSIFY IMAGE \n \(error!.localizedDescription)")
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                print("NOTHING RECOGNIZED")
            } else {
                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                    return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                let description = (classifications.first!.identifier, classifications.first!.confidence)
                print("Classification: \(descriptions.joined(separator: "\n"))")
                self.delegate.didFinishClassification(description)
            }
        }
    }
}
