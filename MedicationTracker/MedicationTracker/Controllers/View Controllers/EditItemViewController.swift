//
//  EditItemViewController.swift
//  MedicationTracker
//
//  Created by ashley llaverias on 3/14/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var itemNamField: UITextField!
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var groupsTableView: UITableView!
    
    // MARK: - Properties
    var item: Item?
    
    var itemController = ItemController.itemController
       var groupController = GroupController.groupController
       var alertManager = AlertManager.alertManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item != nil {
            updateViews()
        }
    }
    
    // MARK: - Methods
    
    func updateViews() {
        
    }
    
    // MARK: - Button Functionality

    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
}
