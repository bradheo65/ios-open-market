//
//  AddProductViewController.swift
//  OpenMarket
//
//  Created by BaekGom, Brad on 2022/07/29.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var addImageCollectionView: UICollectionView!

    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var horizonStackView: UIStackView!
    
    let imagePicker = UIImagePickerController()
    var numberOfCell = 10
    
    private var horizontalUIView: UIView {
        get {
            let uiView = UIView()
            uiView.translatesAutoresizingMaskIntoConstraints = false
            return uiView
        }
        set{}
    }
    
    private var emptyStackView: UIStackView {
        get {
            let stackview = UIStackView()
            stackview.translatesAutoresizingMaskIntoConstraints = false
            return stackview
        }
        set {}
    }
    
    private var postImageView: UIImageView {
        get {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }
        set{}
    }
    
    func addImageView() {
        self.horizontalUIView.addSubview(postImageView)
        self.horizonStackView.addSubview(horizontalUIView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self

    }
    
    @IBAction func back(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func pickImage() {
        self.imagePicker.sourceType  = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func loadImageFromLibrary(_ sender: UIButton) {
        pickImage()
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        self.postImageView.image = newImage // 받아온 이미지를
        addImageView()
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
    }
}
