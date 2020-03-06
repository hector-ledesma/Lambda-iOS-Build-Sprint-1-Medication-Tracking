//
//  MainScreenViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit
import UserNotifications

class MainScreenViewController: UIViewController {
    
    var dayController = DayController()
    var itemController = ItemController.itemController
    var alertManager = AlertManager.alertManager
    var groupController = GroupController.groupController
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        requestPermission()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPersistence()
//        var group10name = groupController.groups[10].name
//        let alertgroups = alertManager.alerts.compactMap { $0.group }
//        if let otherGroup = alertgroups.first(where: {
//            $0.name == group10name
//        }) {
//            groupController.groups[10] = otherGroup
//        }
        
        tableView.reloadData()
        
        for groups in groupController.groups {
            print("All in group: \(groups.name) with count of \(groups.items.count)")
        }
        for alerts in alertManager.activeAlerts {
            print("Count: \(alertManager.activeAlerts.count) All in active alerts: \(alerts.group?.name) with count of \(alerts.group?.items.count)")
        }
        
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainMenuSegue" {
            guard let mainMenuVC = segue.destination as? MainMenuViewController else { fatalError("Segue to MainMenu failed.") }
            // MARK: - fix this
//            mainMenuVC.dayController = self.dayController
//            mainMenuVC.itemController = self.itemController
//            mainMenuVC.groupController = self.groupController
        } else if segue.identifier == "EditItemSegue" {
            guard let editVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { fatalError("Segue to MainMenu failed.") }
            //MARK: - Fix this
//            editVC.dayController = self.dayController
//            editVC.itemController = self.itemController
//            editVC.groupController = self.groupController
            
            guard let group = alertManager.activeAlerts[indexPath.row].group else { fatalError() }
            if let activeGroupIndex = groupController.groups.firstIndex(of: group){
                    editVC.identifier = groupController.groups[activeGroupIndex]
            }
            
            editVC.segue = .editGroup
            
        }
    }
    
    // MARK: - Notifications Functionality
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: .alert) { (granted, error) in
            if granted {
                print("Access Granted")
            } else {
                print("D'oh!")
            }
        }
    }
}


// MARK: - Table View Methods

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return groupController.groups.count
        
        return alertManager.activeAlerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell") as? MainScreenTableViewCell else { fatalError("Could not convert items to cells") }
//        let activeAlert = alertManager.activeAlerts[indexPath.row]
        
        guard var group = alertManager.activeAlerts[indexPath.row].group else {fatalError()}
//        guard let group = groupController.groups.first(where: { $0 == groupFromAlert }) else { fatalError()}
        
            cell.identifier = group
        
        
        
//        guard let group = alertManager.activeAlerts[indexPath.row].group else { fatalError() }
//        if let activeGroupIndex = groupController.groups.firstIndex(of: group) {
//            cell.identifier = groupController.groups[activeGroupIndex]
//        }
        
//        cell.identifier = alertManager.activeAlerts[indexPath.row].group
        
        
        return cell
    }
  
}


// MARK: - Permanence Methods
extension MainScreenViewController{
    
    func loadPersistence() {
        itemController.loadFromPersistentStore()
        groupController.loadFromPersistentStore()
        alertManager.loadFromPersistentStore()
        
        for group in groupController.groups {
            for alert in alertManager.alerts {
                if alert.group?.name == group.name {
                    alert.group = group
                }
            }
        }
        
    }
    
    func savePersistence() {
        itemController.saveToPersistentStore()
        groupController.saveToPersistentStore()
        alertManager.saveToPersistentStore()
    }
}

// MARK: - Delegate Methods

extension MainScreenViewController {
    func updateViews() {
        tableView.reloadData()
    }
}
