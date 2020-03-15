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
    }

}
