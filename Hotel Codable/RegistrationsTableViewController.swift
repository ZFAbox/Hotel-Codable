//
//  RegistrationsTableViewController.swift
//  Hotel Codable
//
//  Created by Fedor on 15.08.2025.
//

import UIKit

class RegistrationsTableViewController: UITableViewController {
    
    private var registrations: [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = segue.source as? AddRegistrationTableViewController else { return }
        if let registration = addRegistrationTableViewController.registration {
            registrations.append(registration)
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registrationCell", for: indexPath)
        let registration = registrations[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = registration.firstName + " " + registration.lastName
        content.secondaryText = "\(registration.checkInDate.formatted(date: .numeric, time: .omitted)) - \(registration.checkOutDate.formatted(date: .numeric, time: .omitted)): \(registration.roomType.name)"
        cell.contentConfiguration = content
        return cell
    }
}
