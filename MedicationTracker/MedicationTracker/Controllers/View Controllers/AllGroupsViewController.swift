//
//  AllGroupsViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/5/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

protocol EditGroupDelegate {
    func groupUpdated()
}

class AllGroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var allGroupsTableView: UITableView!
    
    var groupController = GroupController.groupController
    var alertManager = AlertManager.alertManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsTableView.delegate = self
        allGroupsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allGroupsTableView.reloadData()
        print(groupController.groups.count)
    }
    
    // MARK: - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupController.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsIdentifier") as? AllViewTableViewCell else { fatalError() }
        
        let group = groupController.groups[indexPath.row]
        cell.groupNameLabel.text = group.name
        cell.groupCountLabel.text = group.items.count > 1 ? "\(groupController.groups[indexPath.row].items.count) items" : "\(groupController.groups[indexPath.row].items.count) item"
        
        cell.groupButtonAction = {
            print("Hit")
            for activeAlert in self.alertManager.activeAlerts {
                if activeAlert.group == group {
                    self.alertManager.deleteAlert(identifier: group as Identifier)
                }
            }
            self.groupController.delete(group: group)
            self.savePersistence()
            self.allGroupsTableView.reloadData()
        }
        return cell
    }
    
    // MARK: - Methods
    
    func savePersistence() {
        alertManager.saveToPersistentStore()
        groupController.saveToPersistentStore()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditGroupSegue" {
            guard let groupEditVC = segue.destination as? EditGroupViewController,
                let indexPath = allGroupsTableView.indexPathForSelectedRow else { fatalError() }
            
            groupEditVC.group = groupController.groups[indexPath.row]
            groupEditVC.delegate = self
        }
    }

}

extension AllGroupsViewController: DetailViewDelegate {
    func updateViews() {
        allGroupsTableView.reloadData()
    }
}

extension AllGroupsViewController: EditGroupDelegate {
    func groupUpdated() {
        allGroupsTableView.reloadData()
    }
    
    
}
