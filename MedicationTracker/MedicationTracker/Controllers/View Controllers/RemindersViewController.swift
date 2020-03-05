//
//  RemindersViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController {

    @IBOutlet weak var remindersTableView: UITableView!
    
    var itemController = ItemController.itemController
    var groupController = GroupController.groupController
    var alertManager = AlertManager.alertManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remindersTableView.delegate = self
        remindersTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

// MARK: - Table View Functionality

extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertManager.alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as? RemindersTableViewCell else { fatalError() }
        cell.alert = alertManager.alerts[indexPath.row]
        
        return cell
    }
    
    
}
