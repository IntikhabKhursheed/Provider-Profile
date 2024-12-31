//
//  CalenderViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 23/12/2024.
//
import UIKit

protocol CalenderDelegate: AnyObject {
    func didSelectDate(_ date: Date)
    func didCancel()
}

class CalenderViewController: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    private var dimmingView: UIView! // Dimming background view
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    weak var delegate: CalenderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addDimmingEffect()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let viewHeight = screenHeight * 0.7
        let yPosition = screenHeight - viewHeight
        self.view.frame = CGRect(x: 0, y: yPosition, width: screenWidth, height: viewHeight)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        datePicker.datePickerMode = .date
        datePicker.tintColor = blueC
        
        cancelButton.layer.cornerRadius = 25
        cancelButton.layer.borderColor = blueC.cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.tintColor = blueC
        
        okButton.layer.cornerRadius = 25
        okButton.backgroundColor = blueC
        okButton.tintColor = UIColor.white
        
    }
    
    
    private func addDimmingEffect() {
        guard let presentingView = presentingViewController?.view else { return }
        
        dimmingView = UIView(frame: presentingView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dimmingView.alpha = 0
        presentingView.addSubview(dimmingView)
        
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        } completion: { _ in
            self.dimmingView.removeFromSuperview()
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.didCancel()
        }
    }
    
    @IBAction func okTapped(_ sender: UIButton) {
        let selectedDate = datePicker.date
        dismiss(animated: true) {
            self.delegate?.didSelectDate(selectedDate)
        }
    }

}
extension CalenderViewController: CalenderDelegate {
    func didSelectDate(_ date: Date) {
        print("Selected date: \(date)")
        // Handle the selected date here if necessary
    }

    func didCancel() {
        print("Date selection canceled")
        // Handle cancellation here if necessary
    }
}

