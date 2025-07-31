//
//  AddRegistrationTableViewController.swift
//  Hotel Codable
//
//  Created by Федор Завьялов on 29.07.2025.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    //Section 1
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var seconfNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //Section 2
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightTodayDate = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightTodayDate
        checkInDatePicker.date = midnightTodayDate
        
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: midnightTodayDate)
        updateDateViews()
    }
    
    private func updateDateViews() {
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func doneBarButton(_ sender: Any) {
        
        let firstName = firstNameTextField.text ?? ""
        let secondName = seconfNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        print("Done button tapped!")
        print("First Name: \(firstName)")
        print("Second Name: \(secondName)")
        print("Email: \(email)")
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
}
