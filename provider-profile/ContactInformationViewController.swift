//
//  ContactInformationViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 26/12/2024.
//

import UIKit

struct CountryPhone {
    let name: String
    let dialCode: String
    let code: String
    let maxLength: Int
}

class ContactInformationViewController: UIViewController, CountryPickerDelegate {
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var homeNumber: UITextField!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var contactRelationship: UITextField!
    @IBOutlet weak var saveAndContinue: UIButton!
    @IBOutlet weak var skipNowbtn: UIButton!
    @IBOutlet weak var completeLater: UIButton!

    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldObservers()
        updateSaveButtonState()
        
        // Add tap action for mobile and contact number fields
        mobileNumber.addTarget(self, action: #selector(openCountryPicker), for: .editingDidBegin)
        contactNumber.addTarget(self, action: #selector(openCountryPicker), for: .editingDidBegin)
        
        mobileNumber.addTarget(self, action: #selector(formatPhoneNumber(_:)), for: .editingChanged)
        contactNumber.addTarget(self, action: #selector(formatPhoneNumber(_:)), for: .editingChanged)
    }
    
    private func setupUI() {
        let textFields = [mobileNumber, homeNumber, contactName, contactNumber, contactRelationship]
        textFields.compactMap { $0 }.forEach { configureTextField($0) }
        
        skipNowbtn.layer.borderColor = blueC.cgColor
        skipNowbtn.layer.borderWidth = 1
        skipNowbtn.layer.cornerRadius = 25
        skipNowbtn.configuration = nil
        skipNowbtn.setTitle("Skip Now", for: .normal)
        skipNowbtn.setTitleColor(blueC, for: .normal)
        
        completeLater.configuration = nil
        completeLater.setTitle("Complete Profile Later", for: .normal)
        completeLater.setTitleColor(blueC, for: .normal)
        
        saveAndContinue.layer.cornerRadius = 25
    }
    
    private func configureTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
    }
    
    private func setupTextFieldObservers() {
        [mobileNumber, homeNumber, contactName, contactNumber, contactRelationship].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }

    @objc private func textFieldDidChange() {
        updateSaveButtonState()
    }
    
    func loadViewController(withIdentifier identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)

        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    
    @IBAction func skipNowButton(_ sender: Any) {
        loadViewController(withIdentifier: "SpecialityViewController")
    }

    private func updateSaveButtonState() {
        let allFieldsFilled = [mobileNumber, homeNumber, contactName, contactNumber, contactRelationship].allSatisfy { textField in
            guard let text = textField?.text else { return false }
            return !text.trimmingCharacters(in: .whitespaces).isEmpty
        }
        
        saveAndContinue.isEnabled = allFieldsFilled
        saveAndContinue.backgroundColor = allFieldsFilled ? blueC : lightGrayBlueColor
        saveAndContinue.setTitleColor(allFieldsFilled ? UIColor.white : UIColor.darkGray, for: .normal)
    }
    
    @objc func openCountryPicker() {
        activeTextField = (mobileNumber.isEditing) ? mobileNumber : contactNumber
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let countryPickerVC = storyboard.instantiateViewController(withIdentifier: "CountryPickerViewController") as? CountryPickerViewController {
            countryPickerVC.delegate = self
            present(countryPickerVC, animated: true, completion: nil)
        }
    }
    
    // CountryPickerDelegate Method
    func didSelectCountry(_ countryCode: String, flagName: String) {
        guard let activeTextField = activeTextField else { return }
        
        // Set the text field with the country code
        activeTextField.text = countryCode + " "
        
        // Add the flag as the left view with padding
        let imageName = "country_flag_\(flagName.lowercased())" // Example: "country_flag_af"
        if let flagImage = UIImage(named: imageName) {
            let resizedImage = resizeImage(image: flagImage, targetSize: CGSize(width: 24, height: 24))
            
            let imageView = UIImageView(image: resizedImage)
            imageView.contentMode = .scaleAspectFit
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: 24)) // Add padding to the flag
            imageView.frame = CGRect(x: 5, y: 0, width: 24, height: 24) // Center the flag image within padding
            paddingView.addSubview(imageView)
            
            activeTextField.leftView = paddingView
            activeTextField.leftViewMode = .always
        } else {
            print("Flag image not found for \(imageName)")
        }
    }
    @objc func formatPhoneNumber(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // Remove all non-numeric characters
        let digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // Apply formatting based on length
        var formattedNumber = ""
        
        if digits.count > 0 {
            formattedNumber += "+"
        }
        
        if digits.count > 1 {
            let startIndex = digits.startIndex
            let endIndex = digits.index(startIndex, offsetBy: 2, limitedBy: digits.endIndex) ?? digits.endIndex
            formattedNumber += digits[startIndex..<endIndex] // Country code (e.g., +61)
        }
        
        if digits.count > 2 {
            formattedNumber += " "
            let startIndex = digits.index(digits.startIndex, offsetBy: 2)
            let endIndex = digits.index(startIndex, offsetBy: 3, limitedBy: digits.endIndex) ?? digits.endIndex
            formattedNumber += digits[startIndex..<endIndex] // First block (e.g., 555)
        }
        
        if digits.count > 5 {
            formattedNumber += "-"
            let startIndex = digits.index(digits.startIndex, offsetBy: 5)
            let endIndex = digits.index(startIndex, offsetBy: 3, limitedBy: digits.endIndex) ?? digits.endIndex
            formattedNumber += digits[startIndex..<endIndex] // Second block (e.g., 555)
        }
        
        if digits.count > 8 {
            formattedNumber += "-"
            let startIndex = digits.index(digits.startIndex, offsetBy: 8)
            formattedNumber += String(digits[startIndex...]) // Remaining digits
        }
        
        // Update the text field
        textField.text = formattedNumber
    }

    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)

        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(origin: .zero, size: newSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? image
    }
}

