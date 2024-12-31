import UIKit

class IncorporatedStatusViewController: UIViewController {
    @IBOutlet weak var yesRadioButton: UIButton!
    @IBOutlet weak var noRadioButton: UIButton!
    @IBOutlet weak var IconAnesthesisRadioButton: UIButton!
    @IBOutlet weak var iconExchangeRadioButton: UIButton!
    @IBOutlet weak var otherRadioButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var identificationNameTextField: UITextField!
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    @IBOutlet weak var skipNowBtn: UIButton!
    @IBOutlet weak var completeLaterBtn: UIButton!
    @IBOutlet weak var detailsContainerView: UIView!
    
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    let slightlyDarkerGray = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
    private var additionalButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRadioButtons()
        updateVisibility()
    }

    private func setupUI() {
        skipNowBtn.layer.borderColor = blueC.cgColor
        skipNowBtn.layer.borderWidth = 1
        skipNowBtn.layer.cornerRadius = 25
        skipNowBtn.configuration = nil
        skipNowBtn.setTitle("Skip Now", for: .normal)
        skipNowBtn.setTitleColor(blueC, for: .normal)
        
        completeLaterBtn.configuration = nil
        completeLaterBtn.setTitle("Complete Profile Later", for: .normal)
        completeLaterBtn.setTitleColor(blueC, for: .normal)
        
        saveAndContinueBtn.layer.cornerRadius = 25
        saveAndContinueBtn.backgroundColor = blueC
        saveAndContinueBtn.setTitleColor(UIColor.white, for: .normal)
        
        companyNameTextField.borderStyle = .roundedRect
        companyNameTextField.layer.borderWidth = 1.0
        companyNameTextField.layer.borderColor = slightlyDarkerGray.cgColor
        companyNameTextField.layer.cornerRadius = 8


        identificationNameTextField.borderStyle = .roundedRect
        identificationNameTextField.layer.borderWidth = 1.0
        identificationNameTextField.layer.borderColor = slightlyDarkerGray.cgColor
        identificationNameTextField.layer.cornerRadius = 8
    }

    private func setupRadioButtons() {
        additionalButtons = [IconAnesthesisRadioButton, iconExchangeRadioButton, otherRadioButton]
        
        // Configure Yes and No buttons
        configureRadioButton(yesRadioButton, selector: #selector(yesButtonTapped))
        configureRadioButton(noRadioButton, selector: #selector(noButtonTapped))
        
        // Configure additional buttons
        for button in additionalButtons {
            configureRadioButton(button, selector: #selector(additionalButtonTapped(_:)))
        }
    }

    private func configureRadioButton(_ button: UIButton, selector: Selector) {
        button.setImage(UIImage(systemName: "circle"), for: .normal) // Unchecked state
        button.setImage(UIImage(systemName: "largecircle.fill.circle"), for: .selected)
        button.tintColor = blueC
        button.addTarget(self, action: selector, for: .touchUpInside)
    }

    private func updateVisibility() {
        let shouldShow = yesRadioButton.isSelected

        // Show or hide the container view
        detailsContainerView.isHidden = !shouldShow

        // Animate layout changes if needed
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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
        loadViewController(withIdentifier: "mainFormViewController")
    }

    // MARK: - Button Actions

    @objc private func yesButtonTapped() {
        print("Yes button tapped")
        yesRadioButton.isSelected = true

        noRadioButton.isSelected = false

        updateVisibility()
    }

    @objc private func noButtonTapped() {
        print("No button tapped")
        noRadioButton.isSelected = true

        yesRadioButton.isSelected = false
        // Update visibility of fields
        updateVisibility()
    }

    @objc private func additionalButtonTapped(_ sender: UIButton) {
        // Deselect all other additional buttons
        additionalButtons.forEach {
            $0.isSelected = false
            $0.tintColor = UIColor.lightGray
        }

        // Select the tapped button
        sender.isSelected = true
        sender.tintColor = blueC
    }
}
