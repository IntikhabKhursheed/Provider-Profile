//
//  UpdatePhotoViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 31/12/2024.
//

import UIKit

protocol UpdatePhotoDelegate: AnyObject {
    func didUpdatePhoto(_ image: UIImage)
}

class UpdatePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate: UpdatePhotoDelegate?

    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var galleryBTN: UIButton!
    @IBOutlet weak var cameraBTN: UIButton!
    
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    private var backgroundDimView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addDimmingBackground()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Position popup at 30% of screen height
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let popupHeight = screenHeight * 0.5
        let yOffset = screenHeight - popupHeight
        self.view.frame = CGRect(x: 0, y: yOffset, width: screenWidth, height: popupHeight)
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 20
        self.view.layer.masksToBounds = true
    }
    
    private func addDimmingBackground() {
        guard let parentView = presentingViewController?.view else { return }
        
        backgroundDimView = UIView(frame: parentView.bounds)
        backgroundDimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backgroundDimView.alpha = 0
        parentView.addSubview(backgroundDimView)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundDimView.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundDimView.alpha = 0
        } completion: { _ in
            self.backgroundDimView.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        cameraBTN.layer.borderWidth = 1
        cameraBTN.layer.cornerRadius = 8
        cameraBTN.layer.borderColor = UIColor.lightGray.cgColor
        
        galleryBTN.layer.borderWidth = 1
        galleryBTN.layer.cornerRadius = 8
        galleryBTN.layer.borderColor = UIColor.lightGray.cgColor
        
        cancelBTN.backgroundColor = blueC
        cancelBTN.layer.cornerRadius = 25
    }
    
    // MARK: - Button Actions
    @IBAction func cameraButtonTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func galleryButtonTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Photo Library not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
            
    }

    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.didUpdatePhoto(image) // Pass the selected image to the delegate
        }
        picker.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil) // Close UpdatePhotoViewController
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
