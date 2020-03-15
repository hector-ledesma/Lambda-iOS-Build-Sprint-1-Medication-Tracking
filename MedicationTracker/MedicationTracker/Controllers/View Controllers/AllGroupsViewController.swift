//
//  AllGroupsViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/5/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupController.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsIdentifier") as? AllViewTableViewCell else { fatalError() }
        cell.groupNameLabel.text = groupController.groups[indexPath.row].name
        cell.groupCountLabel.text = groupController.groups[indexPath.row].items.count > 1 ? "\(groupController.groups[indexPath.row].items.count) items" : "\(groupController.groups[indexPath.row].items.count) item"
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditGroupSegue" {
        }
    }

}

extension AllGroupsViewController: DetailViewDelegate {
    func updateViews() {
        allGroupsTableView.reloadData()
    }
}
