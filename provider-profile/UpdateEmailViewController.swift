//
//  UpdateEmailViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 30/12/2024.
//

import UIKit

class UpdateEmailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var currentEmailField: UITextField!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    private var currentEmailLabel: UILabel = UILabel()
    private var newEmailLabel: UILabel = UILabel()
    private var backgroundDimView: UIView! // Dimming background view
    
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    let slightlyDarkerGray = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addDimmingBackground()
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
    
    // MARK: - UI Setup
    private func setupView() {
        // Style the popup
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 16
        self.view.layer.masksToBounds = true

        // Style title label
        titleLabel.text = "Update Email"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor.black
        
        // Style text fields


          currentEmailField.borderStyle = .roundedRect
          currentEmailField.layer.borderWidth = 1.0
          currentEmailField.layer.borderColor = slightlyDarkerGray.cgColor
          currentEmailField.layer.cornerRadius = 8


          newEmailField.borderStyle = .roundedRect
          newEmailField.layer.borderWidth = 1.0
          newEmailField.layer.borderColor = slightlyDarkerGray.cgColor
          newEmailField.layer.cornerRadius = 8
        
        // Setup floating placeholders
        setupFloatingPlaceholder(for: currentEmailField, label: currentEmailLabel, text: "Current Email*")
        setupFloatingPlaceholder(for: newEmailField, label: newEmailLabel, text: "New Email*")
        
        // Style buttons
        cancelButton.layer.cornerRadius = 25
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = blueC.cgColor

        updateButton.layer.cornerRadius = 25
        updateButton.backgroundColor = blueC
    }
    
    private func setupFloatingPlaceholder(for textField: UITextField, label: UILabel, text: String) {
        guard let superview = textField.superview else { return }

        // Configure floating label
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = slightlyDarkerGray
        label.alpha = 0.0 // Initially hidden
        label.translatesAutoresizingMaskIntoConstraints = false

        // Add the label to the parent view of the text field
        superview.addSubview(label)

        // Add constraints to position the label exactly on the border
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 12), // Padding from left
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: 1), // Exactly on top border
            label.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -12)
        ])

        // Add actions to animate the placeholder
        textField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingEnded(_:)), for: .editingDidEnd)
    }

    
    private func addDimmingBackground() {
        guard let parentView = presentingViewController?.view else { return }
        
        // Create and add dimming view
        backgroundDimView = UIView(frame: parentView.bounds)
        backgroundDimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        backgroundDimView.alpha = 0
        parentView.addSubview(backgroundDimView)
        
        // Fade in the dimming view
        UIView.animate(withDuration: 0.3) {
            self.backgroundDimView.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Fade out and remove dimming view
        UIView.animate(withDuration: 0.3) {
            self.backgroundDimView.alpha = 0
        } completion: { _ in
            self.backgroundDimView.removeFromSuperview()
        }
    }

    // MARK: - Floating Placeholder Actions
    @objc private func editingBegan(_ textField: UITextField) {
        let label = textField == currentEmailField ? currentEmailLabel : newEmailLabel
        animatePlaceholder(label, textField: textField, active: true)
    }

    @objc private func editingEnded(_ textField: UITextField) {
        let label = textField == currentEmailField ? currentEmailLabel : newEmailLabel
        if let text = textField.text, text.isEmpty {
            animatePlaceholder(label, textField: textField, active: false)
        }
    }


    private func animatePlaceholder(_ label: UILabel, textField: UITextField, active: Bool) {
        let floatingYPosition: CGFloat = 0 // Above the border when active
        let defaultYPosition: CGFloat = 0    // On the border when inactive

        UIView.animate(withDuration: 0.3) {
            label.alpha = active ? 1.0 : 0.0
            label.transform = active
                ? CGAffineTransform(translationX: 0, y: floatingYPosition)
                : CGAffineTransform(translationX: 0, y: defaultYPosition)
        }
    }


    // MARK: - Button Actions
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        guard let currentEmail = currentEmailField.text, !currentEmail.isEmpty,
              let newEmail = newEmailField.text, !newEmail.isEmpty else {
            print("Both fields must be filled out")
            return
        }
        // Handle email update logic here
        print("Email updated from \(currentEmail) to \(newEmail)")
        self.dismiss(animated: true, completion: nil)
    }
}
