//
//  AddressInformationViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 23/12/2024.
//


import UIKit

class AddressInformationViewController: UIViewController {
    
    //Address 1
    @IBOutlet weak var countryNames: UITextField!
    @IBOutlet weak var countryVectorIcon: UIButton!
    @IBOutlet weak var stateNames: UITextField!
    @IBOutlet weak var stateVectorIcon: UIButton!
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var cityVectorIcon: UIButton!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var maxClientDistance: UITextField!
    
    //Address 2 (optional)
    
    @IBOutlet weak var optionalCountryNames: UITextField!
    
    @IBOutlet weak var optionalVectorCountryIcon: UIView!
    @IBOutlet weak var optionalStateNames: UITextField!
    @IBOutlet weak var optionalStateVector: UIButton!
    @IBOutlet weak var optionalCityNames: UIView!
    @IBOutlet weak var optionalCityVector: UIButton!
    @IBOutlet weak var optionalPostal: UITextField!
    @IBOutlet weak var OptionalStreetAddress: UITextField!
    @IBOutlet weak var optionalMaxClient: UITextField!
    
    @IBOutlet weak var timeZone: UITextField!
    @IBOutlet weak var timeZoneVectorIcon: UIButton!
    
    @IBOutlet weak var saveAndContinuebtn: UIButton!
    @IBOutlet weak var skipNowbtn: UIButton!
    @IBOutlet weak var copmpleteLaterbtn: UIButton!
    
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldObservers()
        updateSaveButtonState()
        print("AddressAndTimeZoneViewController Loaded!")
    }
//    @objc func contactInformationTapped() {
//        // Perform your desired action here
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let contactVC = storyboard.instantiateViewController(withIdentifier: "ContactInformationViewController") as? ContactInformationViewController {
//            self.navigationController?.pushViewController(contactVC, animated: true)
//        } else {
//            print("Failed to instantiate ContactInformationViewController")
//        }
//    }
    private func setupUI() {
        let textFields = [countryNames, stateNames, streetAddress, maxClientDistance, cityName, postalCode,optionalCountryNames,optionalStateNames,optionalCityNames,optionalPostal,OptionalStreetAddress,optionalMaxClient,timeZone]
        textFields.compactMap { ($0 as! UITextField) }.forEach { configureTextField($0) }
        
        saveAndContinuebtn.layer.cornerRadius = 25
        saveAndContinuebtn.setTitleColor(lightGray, for: .normal)

        
        skipNowbtn.layer.borderColor = blueC.cgColor
        skipNowbtn.layer.borderWidth = 1
        skipNowbtn.layer.cornerRadius = 25
        skipNowbtn.configuration = nil
        skipNowbtn.setTitle("Skip Now", for: .normal)
        skipNowbtn.setTitleColor(blueC, for: .normal)
        
        copmpleteLaterbtn.configuration = nil
        copmpleteLaterbtn.setTitle("Complete Profile Later", for: .normal)
        copmpleteLaterbtn.setTitleColor(blueC, for: .normal)
        
    }
    
    private func configureTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
    }
    private func setupTextFieldObservers() {
        // Add observers for editing changes in all text fields
        [countryNames, stateNames, cityName, postalCode, streetAddress, maxClientDistance,timeZone].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
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
        loadViewController(withIdentifier: "ContactInformationViewController")
    }
    
    @objc private func textFieldDidChange() {
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        // Check if all text fields are filled
        let allFieldsFilled = [countryNames, stateNames, cityName, postalCode, streetAddress, maxClientDistance,timeZone].allSatisfy { textField in
            guard let text = textField?.text else { return false }
            return !text.trimmingCharacters(in: .whitespaces).isEmpty
        }
        
        // Update button state based on the result
        saveAndContinuebtn.isEnabled = allFieldsFilled
        saveAndContinuebtn.backgroundColor = allFieldsFilled ? blueC : lightGrayBlueColor
        saveAndContinuebtn.setTitleColor(allFieldsFilled ? UIColor.white : UIColor.darkGray, for: .normal)
    }

    @IBAction func countryVectorIconTapped(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let countryVC = storyboard.instantiateViewController(withIdentifier: "CountryListViewController") as? CountryListViewController {
            countryVC.delegate = self // Set delegate
            countryVC.modalPresentationStyle = .pageSheet // Present as bottom sheet
            present(countryVC, animated: true, completion: nil)
        } else {
            print("Error: Could not instantiate CountryListViewController")
        }
    }
    @IBAction func optionalCountryVectorIconTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let countryVC = storyboard.instantiateViewController(withIdentifier: "CountryListViewController") as? CountryListViewController {
                countryVC.delegate = self // Set delegate
                countryVC.modalPresentationStyle = .pageSheet // Present as bottom sheet
                present(countryVC, animated: true, completion: nil)
            } else {
                print("Error: Could not instantiate CountryListViewController")
            }
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
    print("Save button tapped all fields filled")
    }
}
extension AddressInformationViewController: CountrySelectionDelegate {
    func didSelectCountry(_ country: String) {
        countryNames.text = country // Set the selected country in the text field
    }
}

