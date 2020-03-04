//
//  DetailViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var descStack: UIStackView!
    
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var addedTableView: UITableView!
    @IBOutlet weak var existingItemsTableView: UITableView!
    @IBOutlet weak var itemsStack: UIStackView!
    
    @IBOutlet weak var createAlertSwitch: UISwitch!
    @IBOutlet weak var createAlertStack: UIStackView!
    
    
    
    
    var dayController: DayController?
    var itemController: ItemController?
    var groupController: GroupController?
    var alertManager: AlertManager?
    var segue: SegueIdentifier?
    
    // Array for new group
    var itemsToBeAdded: [Item] = []
    
    // Item for editing
    var identifier: Identifier?
    var itemsToBeEdited: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        // Set Delegate and Data source for both table views.
        addedTableView.delegate = self
        addedTableView.dataSource = self
        existingItemsTableView.delegate = self
        existingItemsTableView.dataSource = self
        
        nameField.delegate = self
        descField.delegate = self

        // Do any additional setup after loading the view.
    }

    
    func updateView() {
        guard let segue = segue else { return }
        if segue == .newItem {
            titleLabel?.text = "Add Item"
            nameLabel?.text = "Item Name"
            itemsStack.isHidden = true
        } else if segue == .newGroup {
            titleLabel?.text = "Add Group"
            nameLabel?.text = "Group Name"
            descStack.isHidden = true
            createAlertStack.isHidden = false
        } else if segue == .editGroup {
            titleLabel?.text = "Edit Group"
            nameLabel?.text = "Group Name"
            descStack.isHidden = true
            guard var identifier = identifier else { return }
            nameField?.text = identifier.name
            identifier.name = nameField!.text!
            
        }
    }
    
    
    // MARK: - Buttons Functionality
    @IBAction func addItemTapped(_ sender: Any) {
        
    }
    @IBAction func saveTappeed(_ sender: Any) {
        guard let name = nameField.text,
            !name.isEmpty else { return }
        
        if segue == .newItem {
            guard let description = descField.text else { return }
            itemController?.create(name: name, description: description)
            
            
            dismiss(animated: true, completion: nil)
            
        } else if segue == .newGroup {
            guard let newGroup = groupController?.create(name: name, items: itemsToBeAdded) else { fatalError() }
            
            if createAlertSwitch.isOn {
                alertManager?.createAlert(identifier: newGroup)
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
}


// MARK: - Table View Functionality

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        
        //Existing Items will always be the same
        if tableView == self.existingItemsTableView {
            guard let itemsInController = itemController else { fatalError() }
            count = itemsInController.items.count
        }
        
        // Top Table View will vary depending on segue hit
        
        if tableView == self.addedTableView {
            if segue == .newGroup {
                count = itemsToBeAdded.count
            } else if segue == .editGroup {
                guard let group = self.identifier as? Group else { fatalError() }
                count = group.items.count
            }
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemController = itemController else { fatalError("No Item Controller somehow?") }
        var cell: UITableViewCell?
        
        if tableView == self.existingItemsTableView {
        guard let existingCells = tableView.dequeueReusableCell(withIdentifier: "ExistingItemsCell") as? ExistingItemsTableViewCell else { fatalError("Error Casting existing items cells.") }
            
            existingCells.item = itemController.items[indexPath.row]
            cell = existingCells
            
        } else if tableView == self.addedTableView { // Added Table View functionality
            guard let addedCells = tableView.dequeueReusableCell(withIdentifier: "AddedItemsCell") as? AddedItemsTableViewCell else { fatalError("Error Casting Added items Cells") }
            
            if segue == .newGroup {
                addedCells.item = itemsToBeAdded[indexPath.row]
                cell = addedCells
            } else if segue == .editGroup {
                guard let identifier = self.identifier as? Group else { fatalError() }
                let item = identifier.items[indexPath.row]
                addedCells.identifier = item
                
                addedCells.buttonAction = { sender in
                    guard let indexToBeDeleted = identifier.items.firstIndex(of: item) else { fatalError() }
                            identifier.items.remove(at: indexToBeDeleted)
                            self.addedTableView.reloadData()
                }
                
                cell = addedCells
            }
            
        }
        return cell! // If this doesn't update, break app.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.existingItemsTableView {
            guard let itemController = itemController else { fatalError() }
            
            let item = itemController.items[indexPath.row]
            for items in itemsToBeAdded {
                if item == items {
                    print("Item already exists")
                    return
                }
            }
            itemsToBeAdded.append(item)
            self.addedTableView.reloadData()
        }
    }
    
    
}


// MARK: - Text Field Functionality

extension DetailViewController: UITextFieldDelegate {
    @IBAction func editNameField(_ sender: UITextField) {
        if segue! == .editGroup {
            guard let identifier = self.identifier as? Group else { fatalError() }
            identifier.name = sender.text ?? "ERROR WEE WOO"
        }
    }
}
