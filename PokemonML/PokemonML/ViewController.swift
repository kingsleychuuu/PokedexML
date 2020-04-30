//
//  ViewController.swift
//  PokemonML
//
//  Created by admin on 2020-04-26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    let imageView = UIImageView()
    var classificationBox = UIView()
    var classificationLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupNavigationBar()
        setupImage()
    }
    
    fileprivate func setupNavigationBar() {
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openCamera))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    fileprivate func setupImage() {
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func addClassificationBox() {
        classificationBox = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 128))
        classificationBox.backgroundColor = .gray
        self.view.addSubview(classificationBox)
        classificationBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            classificationBox.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 0),
            classificationBox.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 0),
            classificationBox.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            classificationBox.heightAnchor.constraint(equalToConstant: 128)])
        addClassificationLabel()
    }
        
    private func addClassificationLabel() {
        classificationLabel = UILabel()
        classificationLabel.text = "Tap to take a picture of a Pokemon!"
        classificationBox.addSubview(classificationLabel)
        classificationLabel.translatesAutoresizingMaskIntoConstraints = false
        classificationLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            classificationLabel.leftAnchor.constraint(equalTo: classificationBox.leftAnchor),
            classificationLabel.topAnchor.constraint(equalTo: classificationBox.topAnchor),
            classificationLabel.bottomAnchor.constraint(equalTo: classificationBox.bottomAnchor),
            classificationLabel.rightAnchor.constraint(equalTo: classificationBox.rightAnchor),
            ])
    }
    
    func updateImage(image: UIImage) {
        self.imageView.image = image
    }
    
    private func addCamera() { 
        // Instantiate cameraController
        let cameraController = CameraViewController()
        self.addChild(cameraController)
        cameraController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(cameraController.view)
        cameraController.didMove(toParent: self)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate {
    @objc func openCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        imageView.image = image
    }
}

