//
//  SpecialityCell.swift
//  provider-profile
//
//  Created by Abdul Manan on 30/12/2024.
//

import UIKit

class SpecialityCell: UITableViewCell {

    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    var isChecked: Bool = false 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkboxTapped(_ sender: Any) {
        // Toggle the checkbox state
        isChecked.toggle()
        let imageName = isChecked ? "checkmark.square.fill" : "square"
        checkboxButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
