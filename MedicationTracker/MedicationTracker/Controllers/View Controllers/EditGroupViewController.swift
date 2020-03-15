//
//  EditGroupViewController.swift
//  MedicationTracker
//
//  Created by ashley llaverias on 3/15/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class EditGroupViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var groupNameLabel: UITextField!
    @IBOutlet weak var addedItemsTableView: UITableView!
    @IBOutlet weak var existingItemsTableView: UITableView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var alertSwitch: UISwitch!
    
    // MARK: - Properties
    
    var group: Group?
    
    // MARK: - Controllers
    
    var alertManager = AlertManager.alertManager
    var groupController = GroupController.groupController
    var itemController = ItemController.itemController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    // MARK: - Methods
    
    private func setDelegates() {
        addedItemsTableView.delegate = self
        addedItemsTableView.dataSource = self
        existingItemsTableView.delegate = self
        existingItemsTableView.dataSource = self
    }

}

// MARK: - Extensions

extension EditGroupViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addedItemsTableView {
            return 0
        } else if tableView == existingItemsTableView {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
