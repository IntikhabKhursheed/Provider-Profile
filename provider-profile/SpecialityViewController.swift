//
//  SpecialityViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 30/12/2024.
//

import UIKit

class SpecialityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveAndContinueBtn: UIButton!
    @IBOutlet weak var skipNowBtn: UIButton!
    @IBOutlet weak var completeLaterBtn: UIButton!
    
    public let lightGrayBlueColor = UIColor(red: 241/255, green: 247/255, blue: 250/255, alpha: 1.0)
    public let lightGray = UIColor(red: 139/255.0, green: 147/255.0, blue: 157/255.0, alpha: 1.0)
    public let blueC = UIColor(red: 14/255, green: 115/255, blue: 189/255, alpha: 1.0)
    
    let specialities = ["Anesthesiologist", "Certified Nursing Assistant (CNA)", "Certified Registered Nurse Anesthetist (CRNA)", "Doctor of Dental Medicine (DMD)", "Licensed Practical Nurse (LPN)", "Medical Assistant","Nurse Practitioner (NP)","Physician Assistant (PA)", "Registered Nurse (RN)","Others"]

    var selectedSpecialities = Set<Int>() // Tracks selected rows

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        setupUI()
        updateSaveButtonState()
    }
    private func setupUI(){
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
        loadViewController(withIdentifier: "IncorporatedStatusViewController")
    }
    
    @objc private func textFieldDidChange() {
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        // Check if at least one checkbox is selected
        let isCheckboxChecked = selectedSpecialities.count > 0

        // Update button state and appearance
        saveAndContinueBtn.isEnabled = isCheckboxChecked
        saveAndContinueBtn.backgroundColor = isCheckboxChecked ? blueC : lightGrayBlueColor
        saveAndContinueBtn.setTitleColor(isCheckboxChecked ? UIColor.white : UIColor.darkGray, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialityCell", for: indexPath) as! SpecialityCell

        let speciality = specialities[indexPath.row]
        cell.specialityLabel.text = speciality

        // Update checkbox state
        if selectedSpecialities.contains(indexPath.row) {
            cell.checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        }

        // Set tag and action for checkbox button
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton.addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)

        return cell
    }

    @objc func checkboxTapped(_ sender: UIButton) {
        let index = sender.tag

        if selectedSpecialities.contains(index) {
            selectedSpecialities.remove(index)
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            selectedSpecialities.insert(index)
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.tintColor = blueC
        }

        // Update save button state after checkbox is toggled
        updateSaveButtonState()
    }

}
