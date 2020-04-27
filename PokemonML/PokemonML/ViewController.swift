//
//  ViewController.swift
//  PokemonML
//
//  Created by admin on 2020-04-26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        let image = UIImageView()
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    @objc func openCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
    }
}

