import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addressInformation: UILabel!
    @IBOutlet weak var basicInformation: UILabel!
    @IBOutlet weak var contactInformation: UILabel!
    @IBOutlet weak var speciality: UILabel!
    @IBOutlet weak var incorporatedStatus: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var conainerViewAddresses: UIView!
    
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Enable interaction for all labels
        [addressInformation, basicInformation, contactInformation, speciality, incorporatedStatus].forEach { label in
            label?.isUserInteractionEnabled = true
        }

        // Add gesture recognizers
        addressInformation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddressLabelTap)))
        basicInformation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBasicInfoTap)))
        contactInformation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleContactInfoTap)))
        speciality.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSpecialityTap)))
        incorporatedStatus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIncorporatedStatusTap)))

        // Load the default view on startup
        handleBasicInfoTap()
    }

    @objc func handleAddressLabelTap() {
        updateSelectedLabelAppearance(selectedLabel: addressInformation)
        loadViewController(withIdentifier: "AddressInformationViewController")
    }

    @objc func handleBasicInfoTap() {
        updateSelectedLabelAppearance(selectedLabel: basicInformation)
        loadViewController(withIdentifier: "mainFormViewController")
    }

    @objc func handleContactInfoTap() {
        updateSelectedLabelAppearance(selectedLabel: contactInformation)
        loadViewController(withIdentifier: "ContactInformationViewController")
    }

    @objc func handleSpecialityTap() {
        updateSelectedLabelAppearance(selectedLabel: speciality)
        loadViewController(withIdentifier: "SpecialityViewController")
    }

    @objc func handleIncorporatedStatusTap() {
        updateSelectedLabelAppearance(selectedLabel: incorporatedStatus)
        loadViewController(withIdentifier: "IncorporatedStatusViewController")
    }

    // Function to update the appearance of selected and deselected labels
    func updateSelectedLabelAppearance(selectedLabel: UILabel) {
        let allLabels = [addressInformation, basicInformation, contactInformation, speciality, incorporatedStatus]
        
        allLabels.forEach { label in
            if label == selectedLabel {
                label?.textColor = blueC // Active color
                label?.font = UIFont.boldSystemFont(ofSize: 16)
            } else {
                label?.textColor = .lightGray // Inactive color
                label?.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }

    func loadViewController(withIdentifier identifier: String) {
        // Remove any existing child views
        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }

        // Instantiate and add the new child view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? UIViewController else {
            print("ViewController with identifier \(identifier) could not be instantiated")
            return
        }
        
        addChild(newViewController)
        newViewController.view.frame = containerView.bounds
        containerView.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)
    }
    
    func updateSelectedLabelAppearance(selectedLabel: UILabel, deselectedLabel: UILabel) {
        // Update label appearance to show the selected state
        selectedLabel.textColor = blueC
        selectedLabel.font = UIFont.boldSystemFont(ofSize: selectedLabel.font.pointSize)
        
        deselectedLabel.textColor = .lightGray
        deselectedLabel.font = UIFont.systemFont(ofSize: deselectedLabel.font.pointSize)
    }
}
