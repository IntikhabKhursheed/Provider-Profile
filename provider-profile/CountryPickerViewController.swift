//
//  CountryPickerViewController.swift
//  provider-profile
//
//  Created by Abdul Manan on 26/12/2024.
//

import UIKit

protocol CountryPickerDelegate: AnyObject {
    func didSelectCountry(_ countryCode: String, flagName: String)
}

class CountryPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var delegate: CountryPickerDelegate?
    
    var filteredCountries: [(String, String, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredCountries = getCountries().map { ($0.name, $0.dialCode, $0.code) }
    }
    
    func getCountries() -> [CountryPhone] {
            return [
                CountryPhone(name: "Afghanistan", dialCode: "+93", code: "af", maxLength: 11),
                CountryPhone(name: "Albania", dialCode: "+355", code: "AL", maxLength: 13),
                CountryPhone(name: "Algeria", dialCode: "+213", code: "DZ", maxLength: 12),
                CountryPhone(name: "Andorra", dialCode: "+376", code: "AD", maxLength: 9),
                CountryPhone(name: "Angola", dialCode: "+244", code: "AO", maxLength: 12),
                CountryPhone(name: "Antigua and Barbuda", dialCode: "+1268", code: "AG", maxLength: 16),
                CountryPhone(name: "Argentina", dialCode: "+54", code: "AR", maxLength: 13),
                CountryPhone(name: "Armenia", dialCode: "+374", code: "AM", maxLength: 12),
                CountryPhone(name: "Australia", dialCode: "+61", code: "AU", maxLength: 13),
                CountryPhone(name: "Austria", dialCode: "+43", code: "AT", maxLength: 13),
                CountryPhone(name: "Azerbaijan", dialCode: "+994", code: "AZ", maxLength: 13),
                CountryPhone(name: "Bahamas", dialCode: "+1242", code: "BS", maxLength: 16),
                CountryPhone(name: "Bahrain", dialCode: "+973", code: "BH", maxLength: 11),
                CountryPhone(name: "Bangladesh", dialCode: "+880", code: "BD", maxLength: 14),
                CountryPhone(name: "Barbados", dialCode: "+1246", code: "BB", maxLength: 16),
                CountryPhone(name: "Belarus", dialCode: "+375", code: "BY", maxLength: 13),
                CountryPhone(name: "Belgium", dialCode: "+32", code: "BE", maxLength: 12),
                CountryPhone(name: "Belize", dialCode: "+501", code: "BZ", maxLength: 12),
                CountryPhone(name: "Benin", dialCode: "+229", code: "BJ", maxLength: 12),
                CountryPhone(name: "Bhutan", dialCode: "+975", code: "BT", maxLength: 10),
                CountryPhone(name: "Bolivia", dialCode: "+591", code: "BO", maxLength: 12),
                CountryPhone(name: "Bosnia and Herzegovina", dialCode: "+387", code: "BA", maxLength: 12),
                CountryPhone(name: "Botswana", dialCode: "+267", code: "BW", maxLength: 11),
                CountryPhone(name: "Brazil", dialCode: "+55", code: "BR", maxLength: 13),
                CountryPhone(name: "Brunei", dialCode: "+673", code: "BN", maxLength: 10),
                CountryPhone(name: "Bulgaria", dialCode: "+359", code: "BG", maxLength: 12),
                CountryPhone(name: "Burkina Faso", dialCode: "+226", code: "BF", maxLength: 12),
                CountryPhone(name: "Burundi", dialCode: "+257", code: "BI", maxLength: 12),
                CountryPhone(name: "Cambodia", dialCode: "+855", code: "KH", maxLength: 12),
                CountryPhone(name: "Cameroon", dialCode: "+237", code: "CM", maxLength: 12),
                CountryPhone(name: "Canada", dialCode: "+1", code: "CA", maxLength: 14),
                CountryPhone(name: "Cape Verde", dialCode: "+238", code: "CV", maxLength: 12),
                CountryPhone(name: "Central African Republic", dialCode: "+236", code: "CF", maxLength: 12),
                CountryPhone(name: "Chad", dialCode: "+235", code: "TD", maxLength: 12),
                CountryPhone(name: "Chile", dialCode: "+56", code: "CL", maxLength: 12),
                CountryPhone(name: "China", dialCode: "+86", code: "CN", maxLength: 13),
                CountryPhone(name: "Colombia", dialCode: "+57", code: "CO", maxLength: 12),
                CountryPhone(name: "Comoros", dialCode: "+269", code: "KM", maxLength: 12),
                CountryPhone(name: "Congo (Congo-Brazzaville)", dialCode: "+242", code: "CG", maxLength: 12),
                CountryPhone(name: "Congo (DRC)", dialCode: "+243", code: "CD", maxLength: 12),
                CountryPhone(name: "Costa Rica", dialCode: "+506", code: "CR", maxLength: 12),
                CountryPhone(name: "Croatia", dialCode: "+385", code: "HR", maxLength: 12),
                CountryPhone(name: "Cuba", dialCode: "+53", code: "CU", maxLength: 11),
                CountryPhone(name: "Cyprus", dialCode: "+357", code: "CY", maxLength: 11),
                CountryPhone(name: "Czechia (Czech Republic)", dialCode: "+420", code: "CZ", maxLength: 12),
                CountryPhone(name: "Denmark", dialCode: "+45", code: "DK", maxLength: 11),
                CountryPhone(name: "Djibouti", dialCode: "+253", code: "DJ", maxLength: 11),
                CountryPhone(name: "Dominica", dialCode: "+1767", code: "DM", maxLength: 16),
                CountryPhone(name: "Dominican Republic", dialCode: "+1809", code: "DO", maxLength: 16),
                CountryPhone(name: "Ecuador", dialCode: "+593", code: "EC", maxLength: 12),
                CountryPhone(name: "Egypt", dialCode: "+20", code: "EG", maxLength: 12),
                CountryPhone(name: "El Salvador", dialCode: "+503", code: "SV", maxLength: 12),
                CountryPhone(name: "Equatorial Guinea", dialCode: "+240", code: "GQ", maxLength: 12),
                CountryPhone(name: "Eritrea", dialCode: "+291", code: "ER", maxLength: 12),
                CountryPhone(name: "Estonia", dialCode: "+372", code: "EE", maxLength: 12),
                CountryPhone(name: "Eswatini (Swaziland)", dialCode: "+268", code: "SZ", maxLength: 11),
                CountryPhone(name: "Ethiopia", dialCode: "+251", code: "ET", maxLength: 12),
                CountryPhone(name: "Fiji", dialCode: "+679", code: "FJ", maxLength: 10),
                CountryPhone(name: "Finland", dialCode: "+358", code: "FI", maxLength: 12),
                CountryPhone(name: "France", dialCode: "+33", code: "FR", maxLength: 12),
                CountryPhone(name: "Gabon", dialCode: "+241", code: "GA", maxLength: 12),
                CountryPhone(name: "Gambia", dialCode: "+220", code: "GM", maxLength: 10),
                CountryPhone(name: "Georgia", dialCode: "+995", code: "GE", maxLength: 12),
                CountryPhone(name: "Germany", dialCode: "+49", code: "DE", maxLength: 12),
                CountryPhone(name: "Ghana", dialCode: "+233", code: "GH", maxLength: 12),
                CountryPhone(name: "Greece", dialCode: "+30", code: "GR", maxLength: 12),
                CountryPhone(name: "Grenada", dialCode: "+1473", code: "GD", maxLength: 16),
                CountryPhone(name: "Guatemala", dialCode: "+502", code: "GT", maxLength: 12),
                CountryPhone(name: "Guinea", dialCode: "+224", code: "GN", maxLength: 12),
                CountryPhone(name: "Guinea-Bissau", dialCode: "+245", code: "GW", maxLength: 12),
                CountryPhone(name: "Guyana", dialCode: "+592", code: "GY", maxLength: 12),
                CountryPhone(name: "Haiti", dialCode: "+509", code: "HT", maxLength: 12),
                CountryPhone(name: "Honduras", dialCode: "+504", code: "HN", maxLength: 12),
                CountryPhone(name: "Hungary", dialCode: "+36", code: "HU", maxLength: 12),
                CountryPhone(name: "Iceland", dialCode: "+354", code: "IS", maxLength: 11),
                CountryPhone(name: "India", dialCode: "+91", code: "IN", maxLength: 13),
                CountryPhone(name: "Indonesia", dialCode: "+62", code: "ID", maxLength: 12),
                CountryPhone(name: "Iran", dialCode: "+98", code: "IR", maxLength: 12),
                CountryPhone(name: "Iraq", dialCode: "+964", code: "IQ", maxLength: 12),
                CountryPhone(name: "Ireland", dialCode: "+353", code: "IE", maxLength: 12),
                CountryPhone(name: "Israel", dialCode: "+972", code: "IL", maxLength: 12),
                CountryPhone(name: "Italy", dialCode: "+39", code: "IT", maxLength: 12),
                CountryPhone(name: "Jamaica", dialCode: "+1876", code: "JM", maxLength: 16),
                CountryPhone(name: "Japan", dialCode: "+81", code: "JP", maxLength: 12),
                CountryPhone(name: "Jordan", dialCode: "+962", code: "JO", maxLength: 12),
                CountryPhone(name: "Kazakhstan", dialCode: "+7", code: "KZ", maxLength: 12),
                CountryPhone(name: "Kenya", dialCode: "+254", code: "KE", maxLength: 12),
                CountryPhone(name: "Kiribati", dialCode: "+686", code: "KI", maxLength: 10),
                CountryPhone(name: "Kuwait", dialCode: "+965", code: "KW", maxLength: 11),
                CountryPhone(name: "Kyrgyzstan", dialCode: "+996", code: "KG", maxLength: 13),
                CountryPhone(name: "Laos", dialCode: "+856", code: "LA", maxLength: 12),
                CountryPhone(name: "Latvia", dialCode: "+371", code: "LV", maxLength: 12),
                CountryPhone(name: "Lebanon", dialCode: "+961", code: "LB", maxLength: 12),
                CountryPhone(name: "Lesotho", dialCode: "+266", code: "LS", maxLength: 12),
                CountryPhone(name: "Liberia", dialCode: "+231", code: "LR", maxLength: 12),
                CountryPhone(name: "Libya", dialCode: "+218", code: "LY", maxLength: 12),
                CountryPhone(name: "Liechtenstein", dialCode: "+423", code: "LI", maxLength: 12),
                CountryPhone(name: "Lithuania", dialCode: "+370", code: "LT", maxLength: 12),
                CountryPhone(name: "Luxembourg", dialCode: "+352", code: "LU", maxLength: 12),
                CountryPhone(name: "Madagascar", dialCode: "+261", code: "MG", maxLength: 12),
                CountryPhone(name: "Malawi", dialCode: "+265", code: "MW", maxLength: 12),
                CountryPhone(name: "Malaysia", dialCode: "+60", code: "MY", maxLength: 12),
                CountryPhone(name: "Maldives", dialCode: "+960", code: "MV", maxLength: 12),
                CountryPhone(name: "Mali", dialCode: "+223", code: "ML", maxLength: 12),
                CountryPhone(name: "Malta", dialCode: "+356", code: "MT", maxLength: 11),
                CountryPhone(name: "Marshall Islands", dialCode: "+692", code: "MH", maxLength: 11),
                CountryPhone(name: "Mauritania", dialCode: "+222", code: "MR", maxLength: 12),
                CountryPhone(name: "Mauritius", dialCode: "+230", code: "MU", maxLength: 12),
                CountryPhone(name: "Mexico", dialCode: "+52", code: "MX", maxLength: 13),
                CountryPhone(name: "Micronesia", dialCode: "+691", code: "FM", maxLength: 11),
                CountryPhone(name: "Moldova", dialCode: "+373", code: "MD", maxLength: 12),
                CountryPhone(name: "Monaco", dialCode: "+377", code: "MC", maxLength: 11),
                CountryPhone(name: "Mongolia", dialCode: "+976", code: "MN", maxLength: 12),
                CountryPhone(name: "Montenegro", dialCode: "+382", code: "ME", maxLength: 12),
                CountryPhone(name: "Morocco", dialCode: "+212", code: "MA", maxLength: 12),
                CountryPhone(name: "Mozambique", dialCode: "+258", code: "MZ", maxLength: 12),
                CountryPhone(name: "Myanmar (Burma)", dialCode: "+95", code: "MM", maxLength: 12),
                CountryPhone(name: "Namibia", dialCode: "+264", code: "NA", maxLength: 12),
                CountryPhone(name: "Nauru", dialCode: "+674", code: "NR", maxLength: 10),
                CountryPhone(name: "Nepal", dialCode: "+977", code: "NP", maxLength: 12),
                CountryPhone(name: "Netherlands", dialCode: "+31", code: "NL", maxLength: 12),
                CountryPhone(name: "New Zealand", dialCode: "+64", code: "NZ", maxLength: 12),
                CountryPhone(name: "Nicaragua", dialCode: "+505", code: "NI", maxLength: 12),
                CountryPhone(name: "Niger", dialCode: "+227", code: "NE", maxLength: 12),
                CountryPhone(name: "Nigeria", dialCode: "+234", code: "NG", maxLength: 12),
                CountryPhone(name: "North Korea", dialCode: "+850", code: "KP", maxLength: 12),
                CountryPhone(name: "North Macedonia", dialCode: "+389", code: "MK", maxLength: 12),
                CountryPhone(name: "Norway", dialCode: "+47", code: "NO", maxLength: 11),
                CountryPhone(name: "Oman", dialCode: "+968", code: "OM", maxLength: 11),
                CountryPhone(name: "Pakistan", dialCode: "+92", code: "PK", maxLength: 13),
                CountryPhone(name: "Palau", dialCode: "+680", code: "PW", maxLength: 11),
                CountryPhone(name: "Panama", dialCode: "+507", code: "PA", maxLength: 12),
                CountryPhone(name: "Papua New Guinea", dialCode: "+675", code: "PG", maxLength: 12),
                CountryPhone(name: "Paraguay", dialCode: "+595", code: "PY", maxLength: 12),
                CountryPhone(name: "Peru", dialCode: "+51", code: "PE", maxLength: 12),
                CountryPhone(name: "Philippines", dialCode: "+63", code: "PH", maxLength: 12),
                CountryPhone(name: "Poland", dialCode: "+48", code: "PL", maxLength: 12),
                CountryPhone(name: "Portugal", dialCode: "+351", code: "PT", maxLength: 12),
                CountryPhone(name: "Qatar", dialCode: "+974", code: "QA", maxLength: 11),
                CountryPhone(name: "Romania", dialCode: "+40", code: "RO", maxLength: 12),
                CountryPhone(name: "Russia", dialCode: "+7", code: "RU", maxLength: 12),
                CountryPhone(name: "Rwanda", dialCode: "+250", code: "RW", maxLength: 12),
                CountryPhone(name: "Saint Kitts and Nevis", dialCode: "+1869", code: "KN", maxLength: 16),
                CountryPhone(name: "Saint Lucia", dialCode: "+1758", code: "LC", maxLength: 16),
                CountryPhone(name: "Saint Vincent and the Grenadines", dialCode: "+1784", code: "VC", maxLength: 16),
                CountryPhone(name: "Samoa", dialCode: "+685", code: "WS", maxLength: 10),
                CountryPhone(name: "San Marino", dialCode: "+378", code: "SM", maxLength: 11),
                CountryPhone(name: "Sao Tome and Principe", dialCode: "+239", code: "ST", maxLength: 11),
                CountryPhone(name: "Saudi Arabia", dialCode: "+966", code: "SA", maxLength: 12),
                CountryPhone(name: "Senegal", dialCode: "+221", code: "SN", maxLength: 12),
                CountryPhone(name: "Serbia", dialCode: "+381", code: "RS", maxLength: 12),
                CountryPhone(name: "Seychelles", dialCode: "+248", code: "SC", maxLength: 11),
                CountryPhone(name: "Sierra Leone", dialCode: "+232", code: "SL", maxLength: 12),
                CountryPhone(name: "Singapore", dialCode: "+65", code: "SG", maxLength: 11),
                CountryPhone(name: "Slovakia", dialCode: "+421", code: "SK", maxLength: 12),
                CountryPhone(name: "Slovenia", dialCode: "+386", code: "SI", maxLength: 12),
                CountryPhone(name: "Solomon Islands", dialCode: "+677", code: "SB", maxLength: 10),
                CountryPhone(name: "Somalia", dialCode: "+252", code: "SO", maxLength: 12),
                CountryPhone(name: "South Africa", dialCode: "+27", code: "ZA", maxLength: 12),
                CountryPhone(name: "South Korea", dialCode: "+82", code: "KR", maxLength: 12),
                CountryPhone(name: "South Sudan", dialCode: "+211", code: "SS", maxLength: 12),
                CountryPhone(name: "Spain", dialCode: "+34", code: "ES", maxLength: 12),
                CountryPhone(name: "Sri Lanka", dialCode: "+94", code: "LK", maxLength: 12),
                CountryPhone(name: "Sudan", dialCode: "+249", code: "SD", maxLength: 12),
                CountryPhone(name: "Suriname", dialCode: "+597", code: "SR", maxLength: 12),
                CountryPhone(name: "Sweden", dialCode: "+46", code: "SE", maxLength: 12),
                CountryPhone(name: "Switzerland", dialCode: "+41", code: "CH", maxLength: 12),
                CountryPhone(name: "Syria", dialCode: "+963", code: "SY", maxLength: 12),
                CountryPhone(name: "Taiwan", dialCode: "+886", code: "TW", maxLength: 12),
                CountryPhone(name: "Tajikistan", dialCode: "+992", code: "TJ", maxLength: 12),
                CountryPhone(name: "Tanzania", dialCode: "+255", code: "TZ", maxLength: 12),
                CountryPhone(name: "Thailand", dialCode: "+66", code: "TH", maxLength: 12),
                CountryPhone(name: "Togo", dialCode: "+228", code: "TG", maxLength: 12),
                CountryPhone(name: "Tonga", dialCode: "+676", code: "TO", maxLength: 10),
                CountryPhone(name: "Trinidad and Tobago", dialCode: "+1868", code: "TT", maxLength: 16),
                CountryPhone(name: "Tunisia", dialCode: "+216", code: "TN", maxLength: 12),
                CountryPhone(name: "Turkey", dialCode: "+90", code: "TR", maxLength: 12),
                CountryPhone(name: "Turkmenistan", dialCode: "+993", code: "TM", maxLength: 12),
                CountryPhone(name: "Tuvalu", dialCode: "+688", code: "TV", maxLength: 10),
                CountryPhone(name: "Uganda", dialCode: "+256", code: "UG", maxLength: 12),
                CountryPhone(name: "Ukraine", dialCode: "+380", code: "UA", maxLength: 12),
                CountryPhone(name: "United Arab Emirates", dialCode: "+971", code: "AE", maxLength: 12),
                CountryPhone(name: "United Kingdom", dialCode: "+44", code: "GB", maxLength: 13),
                CountryPhone(name: "United States", dialCode: "+1", code: "US", maxLength: 14),
                CountryPhone(name: "Uruguay", dialCode: "+598", code: "UY", maxLength: 12),
                CountryPhone(name: "Uzbekistan", dialCode: "+998", code: "UZ", maxLength: 13),
                CountryPhone(name: "Vanuatu", dialCode: "+678", code: "VU", maxLength: 11),
                CountryPhone(name: "Vatican City", dialCode: "+379", code: "VA", maxLength: 12),
                CountryPhone(name: "Venezuela", dialCode: "+58", code: "VE", maxLength: 12),
                CountryPhone(name: "Vietnam", dialCode: "+84", code: "VN", maxLength: 12),
                CountryPhone(name: "Yemen", dialCode: "+967", code: "YE", maxLength: 12),
                CountryPhone(name: "Zambia", dialCode: "+260", code: "ZM", maxLength: 12),
                CountryPhone(name: "Zimbabwe", dialCode: "+263", code: "ZW", maxLength: 12)
            ]
        }
}

extension CountryPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = filteredCountries[indexPath.row]

        cell.textLabel?.text = "\(country.0) \(country.1)"
        let imageName = "country_flag_\(country.2.lowercased())"
        if let flagImage = UIImage(named: imageName) {
            let resizedImage = resizeImage(image: flagImage, targetSize: CGSize(width: 24, height: 24))
            cell.imageView?.image = resizedImage
        }

        return cell
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = filteredCountries[indexPath.row]
        delegate?.didSelectCountry(selectedCountry.1, flagName: selectedCountry.2)
        dismiss(animated: true, completion: nil)
    }
}

extension CountryPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCountries = getCountries().map { ($0.name, $0.dialCode, $0.code) }
        } else {
            filteredCountries = getCountries()
                .filter { $0.name.lowercased().contains(searchText.lowercased()) }
                .map { ($0.name, $0.dialCode, $0.code) }
        }
        tableView.reloadData()
    }
}

