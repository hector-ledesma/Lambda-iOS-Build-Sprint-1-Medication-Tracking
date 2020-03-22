//
//  DetailViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var navButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet var descLabel: UILabel!
    // TODO: Make create item view a text view as well
    @IBOutlet weak var descField: UITextField!
    
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var items2Label: UILabel!
    @IBOutlet weak var addedTableView: UITableView!
    @IBOutlet weak var existingItemsTableView: UITableView!
    
    @IBOutlet weak var createAlertSwitch: UISwitch!
    @IBOutlet weak var createAlertStack: UIStackView!
    
    
    
    
    var itemController = ItemController.itemController
    var groupController = GroupController.groupController
    var alertManager = AlertManager.alertManager
    var segue: SegueIdentifier?
    
    // Array for new group
    var itemsToBeAdded: [Item] = []
    
    // Item for editing
    var identifier: Identifier?
    var itemsToBeEdited: [Item] = []
    
    // Delegate
    var delegate: DetailViewDelegate?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updateViews()
    }

    
    func updateView() {
        guard let segue = segue else { return }
        if segue == .newItem {
            titleLabel?.text = "Add Item"
            nameLabel?.text = "Item Name"
            addedTableView.isHidden = true
            existingItemsTableView.isHidden = true
            itemsLabel.isHidden = true
            items2Label.isHidden = true
        } else if segue == .newGroup {
            titleLabel?.text = "Add Group"
            nameLabel?.text = "Group Name"
            descLabel.isHidden = true
            descField.isHidden = true
            createAlertStack.isHidden = false
        } else if segue == .editGroup {
            navButton.setTitle("Delete", for: .normal)
            titleLabel?.text = "Edit Group"
            nameLabel?.text = "Group Name"
            descLabel.isHidden = true
            descField.isHidden = true
            guard var identifier = identifier else { return }
            nameField?.text = identifier.name
            identifier.name = nameField!.text!
            
        }
    }
    
    
    // MARK: - Buttons Functionality
    @IBAction func navButtonTappeed(_ sender: Any) {
        guard let name = nameField.text,
            !name.isEmpty else { return }
        
        if segue == .newItem {
            guard let description = descField.text else { return }
            itemController.create(name: name, description: description)
            
            savePersistence()
            dismiss(animated: true, completion: nil)
            
        } else if segue == .newGroup {
            let newGroup = groupController.create(name: name, items: itemsToBeAdded)
            
            if createAlertSwitch.isOn {
                alertManager.createAlert(identifier: newGroup)
            }
            
            
            savePersistence()
            dismiss(animated: true, completion: nil)
        } else if segue == .editGroup {
            guard let identifier = identifier else { fatalError() }
            if alertManager.deleteAlert(identifier: identifier) {
                groupController.delete(group: identifier as! Group)
                savePersistence()
                delegate?.updateViews()
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
}


// MARK: - Table View Functionality

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int = 0
        
        //Existing Items will always be the same
        if tableView == self.existingItemsTableView {
            count = itemController.items.count
        }
        
        // Top Table View will vary depending on segue hit
        
        if tableView == self.addedTableView {
            if segue == .newGroup {
                count = itemsToBeAdded.count
            } else if segue == .editGroup {
                if let group = self.identifier as? Group {
                    count = group.items.count
                }
                
            }
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
//                guard let groupFind = groupController.groups.firstIndex(of: identifier) else { fatalError() }
                if let groupFind = groupController.groups.firstIndex(of: identifier) {
                    let group = groupController.groups[groupFind]
                    let item = group.items[indexPath.row]
                    addedCells.identifier = item
                    addedCells.buttonAction = { sender in
                        guard let itemDeleteIndex = group.items.firstIndex(of: item) else { fatalError() }
                        group.items.remove(at: itemDeleteIndex)
                        self.savePersistence()
                        self.loadPersistence()
                        self.addedTableView.reloadData()
                    }
                }
                cell = addedCells
            }
        }
        return cell! // If this doesn't update, break app.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.existingItemsTableView {
            if segue! == .newGroup {
                let item = itemController.items[indexPath.row]
                for items in itemsToBeAdded {
                    if item == items {
                        print("Item already exists")
                        return
                    }
                }
                itemsToBeAdded.append(item)
            } else if segue! == .editGroup {
                guard let group = identifier as? Group else { fatalError() }
                let addItem = itemController.items[indexPath.row]
                for items in group.items {
                    if items == addItem {
                        print("Item already exists.")
                        return
                    }
                }
                group.items.append(addItem)
                savePersistence()
            }
            
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
            savePersistence()
        }
    }
}

extension DetailViewController {
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
        alertManager.saveToPersistentStore()
        groupController.saveToPersistentStore()
    }
}
