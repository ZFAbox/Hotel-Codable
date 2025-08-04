//
//  AddRegistrationTableViewController.swift
//  Hotel Codable
//
//  Created by Федор Завьялов on 29.07.2025.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    private var checkInDatePickerVisibale: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !checkInDatePickerVisibale
        }
    }
    private var checkOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !checkOutDatePickerVisible
        }
    }
    
    private let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
    private let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    private let checkInLabelIndexPath = IndexPath(row: 0, section: 1)
    private let checkOutLabelIndexPath = IndexPath(row: 2, section: 1)
    //Section 1
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var seconfNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //Section 2
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    //Section 3
    @IBOutlet weak var adultsLabelCount: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var childrenLabelCount: UILabel!
    @IBOutlet weak var childrenStepper: UIStepper!
    
    // Section 4
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightTodayDate = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightTodayDate
        checkInDatePicker.date = midnightTodayDate
        
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: midnightTodayDate)
        updateDateViews()
        updateNumberOfGuests()
    }
    
    private func updateDateViews() {
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func doneBarButton(_ sender: Any) {
        
        let firstName = firstNameTextField.text ?? ""
        let secondName = seconfNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDateLabel.text ?? ""
        let checkOutDate = checkOutDateLabel.text ?? ""
        let adultsNumber = adultsLabelCount.text ?? ""
        let childrenNumber = childrenLabelCount.text ?? ""
        
        print("Done button tapped!")
        print("First Name: \(firstName)")
        print("Second Name: \(secondName)")
        print("Email: \(email)")
        print("Check-In Date: \(checkInDate)")
        print("Check-OUt Date: \(checkOutDate)")
        print("Adults number: \(adultsNumber)")
        print("Children number: \(childrenNumber)")
        print("Wi-Fi switch is on: \(wifiSwitch.isOn)")
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
    }
    
    private func updateNumberOfGuests() {
        adultsLabelCount.text = String(Int(adultsStepper.value))
        childrenLabelCount.text = String(Int(childrenStepper.value))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case checkInLabelIndexPath where checkOutDatePickerVisible == false:
            checkInDatePickerVisibale.toggle()
        case checkOutLabelIndexPath where checkInDatePickerVisibale == false:
            checkOutDatePickerVisible.toggle()
        case checkInLabelIndexPath, checkOutLabelIndexPath:
            checkInDatePickerVisibale.toggle()
            checkOutDatePickerVisible.toggle()
        default:
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath where checkInDatePickerVisibale == false :
            return 0
        case checkOutDatePickerIndexPath where checkOutDatePickerVisible == false :
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerIndexPath:
            return 190
        case checkOutDatePickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
}
