//
//  mainFormViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 23/12/2024.
//

import UIKit

class mainFormViewController: UIViewController, CalenderDelegate {
    
    @IBOutlet weak var dpPicture: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var middleName: UITextField!
    @IBOutlet weak var lastNmae: UITextField!
    @IBOutlet weak var maidenName: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var placeOfBirth: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var SSHtextField: UITextField!
    @IBOutlet weak var NPInumber: UITextField!
    @IBOutlet weak var NPIuserName: UITextField!
    @IBOutlet weak var NPIpassword: UITextField!
    @IBOutlet weak var CAQHnumber: UITextField!
    @IBOutlet weak var CAQHuserName: UITextField!
    @IBOutlet weak var CAQHpassword: UITextField!
    @IBOutlet weak var NPIpasswordToggle: UIButton!
    @IBOutlet weak var CAQHpassowrdToggle: UIButton!
    @IBOutlet weak var NPIeyeSplash: UIButton!
    @IBOutlet weak var CAQHeyeSplash: UIButton!
    
    
    @IBOutlet weak var saveAndContinueBTN: UIButton!
    @IBOutlet weak var skipNowBTN: UIButton!
    @IBOutlet weak var completeProfileLaterBTN: UIButton!
    
    var isNPIPasswordVisible = true
    var isCAQHPasswordVisible = true
    
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    
    private func configureEyeSplashButton(_ button: UIButton) {
        let icon = UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(icon, for: .normal)
        button.tintColor = UIColor.lightGray
        button.transform = CGAffineTransform(scaleX: 0.7, y: 0.7) // Adjust size if needed
    }
    private func setupPasswordToggleButtons() {
        // For NPI Password Toggle
        let npiIcon = UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate)
        NPIpasswordToggle.setImage(npiIcon, for: .normal)
        NPIpasswordToggle.tintColor = UIColor.lightGray
        NPIpasswordToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        // For CAQH Password Toggle
        let caqhIcon = UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysTemplate)
        CAQHpassowrdToggle.setImage(caqhIcon, for: .normal)
        CAQHpassowrdToggle.tintColor = UIColor.lightGray
        CAQHpassowrdToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    }
      
    // Implement the CalenderDelegate methods
    func didSelectDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateOfBirth.text = dateFormatter.string(from: date) // Set the date to a text field
    }

    func didCancel() {
        print("Date selection canceled")
    }
    
    private func setupUI(){
        dpPicture.layer.cornerRadius = 65
        
        
        // Configure eye splash icons for NPI and CAQH buttons
        configureEyeSplashButton(NPIeyeSplash)
        configureEyeSplashButton(CAQHeyeSplash)
        
        
        // Array of text fields
        let textFields = [
            firstName, middleName, lastNmae, maidenName, dateOfBirth,
            placeOfBirth, email, SSHtextField, NPInumber, NPIuserName,
            NPIpassword, CAQHnumber, CAQHuserName, CAQHpassword
        ]
        
        saveAndContinueBTN.layer.cornerRadius = 25
        saveAndContinueBTN.layer.backgroundColor = blueC.cgColor
        saveAndContinueBTN.setTitleColor(lightGray, for: .normal)
        
        completeProfileLaterBTN.layer.cornerRadius = 25
        completeProfileLaterBTN.layer.backgroundColor = blueC.cgColor
        completeProfileLaterBTN.setTitleColor(lightGray, for: .normal)
        
        skipNowBTN.layer.borderColor = blueC.cgColor
        skipNowBTN.layer.cornerRadius = 25
        skipNowBTN.layer.borderWidth = 1
        skipNowBTN.tintColor = blueC
        
        
        
        // Apply custom style to each text field
        textFields.compactMap { $0 }.forEach { textField in
            textField.applyCustomStyle(borderColor: UIColor.lightGray, cornerRadius: 8, padding: 10)
        }
    }

    func loadViewController(withIdentifier identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)

        // Remove existing child views
        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        // Add new child view controller
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }



    @IBAction func skipNowButton(_ sender: Any) {
        loadViewController(withIdentifier: "AddressInformationViewController")
    }



    @IBAction func NPIpasswordToggle(_ sender: Any) {
        isNPIPasswordVisible.toggle() // Toggle the visibility flag
        NPIpassword.isSecureTextEntry = !isNPIPasswordVisible // Toggle secure text entry
        
        // Change button image based on visibility
        let imageName = isNPIPasswordVisible ? "eye.fill" : "eye.slash.fill"
        let icon = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        NPIpasswordToggle.setImage(icon, for: .normal)
        NPIpasswordToggle.tintColor = UIColor.lightGray // Set icon color to dark gray
        NPIpasswordToggle.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) // Adjust icon size
    }
    @IBAction func CAQHpasswordToggle(_ sender: Any) {
        isCAQHPasswordVisible.toggle() // Toggle the visibility flag
        CAQHpassword.isSecureTextEntry = !isCAQHPasswordVisible // Toggle secure text entry
        
        // Change button image based on visibility
        let imageName = isCAQHPasswordVisible ? "eye.fill" : "eye.slash.fill"
        let icon = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        CAQHpassowrdToggle.setImage(icon, for: .normal)
        CAQHpassowrdToggle.tintColor = UIColor.lightGray // Set icon color to dark gray
        CAQHpassowrdToggle.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
    @IBAction func emailIcon(_ sender: Any) {
        // Create an instance of the popup view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let updateEmailVC = storyboard.instantiateViewController(withIdentifier: "UpdateEmailViewController") as? UpdateEmailViewController {
            updateEmailVC.modalPresentationStyle = .formSheet // Present as a modal form
            updateEmailVC.modalTransitionStyle = .crossDissolve // Smooth transition animation
            self.present(updateEmailVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func editPhotoTapped(_ sender: Any) {
        // Create an instance of the popup view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let updatePhotoVC = storyboard.instantiateViewController(withIdentifier: "UpdatePhotoViewController") as? UpdatePhotoViewController {
            updatePhotoVC.delegate = self // Set delegate
            updatePhotoVC.modalPresentationStyle = .formSheet
            updatePhotoVC.modalTransitionStyle = .crossDissolve
            self.present(updatePhotoVC, animated: true, completion: nil)
        }
    }
    @IBAction func calculatorIcon(_ sender: Any) {
        // Present the Calendar View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalenderViewController") as? CalenderViewController {
            calendarVC.modalPresentationStyle = .overCurrentContext
            calendarVC.delegate = self // Assign the delegate here
            self.present(calendarVC, animated: true, completion: nil)
        }
    }
}

extension UITextField {
    func applyCustomStyle(borderColor: UIColor = .lightGray, cornerRadius: CGFloat = 8, padding: CGFloat = 10) {
        // Border
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = cornerRadius
        
        // Padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension mainFormViewController: UpdatePhotoDelegate {
    func didUpdatePhoto(_ image: UIImage) {
        dpPicture.image = image // Update the profile picture
    }
}
