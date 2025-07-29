//
//  AddRegistrationTableViewController.swift
//  Hotel Codable
//
//  Created by Федор Завьялов on 29.07.2025.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var seconfNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}
