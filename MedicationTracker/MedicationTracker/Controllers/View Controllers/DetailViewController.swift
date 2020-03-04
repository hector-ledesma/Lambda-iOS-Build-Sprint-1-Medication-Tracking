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
    
    
    
    var dayController: DayController?
    var itemController: ItemController?
    var groupController: GroupController?
    var alertManager: AlertManager?
    var segue: String?
    
    var itemsToBeAdded: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        // Set Delegate and Data source for both table views.
        addedTableView.delegate = self
        addedTableView.dataSource = self
        existingItemsTableView.delegate = self
        existingItemsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    func updateView() {
        guard let segue = segue else { return }
        if segue == "Item" {
            titleLabel?.text = "Add Item"
            nameLabel?.text = "Item Name"
            itemsStack.isHidden = true
        } else if segue == "Group" {
            titleLabel?.text = "Add Group"
            nameLabel?.text = "Group Name"
            descStack.isHidden = true
        }
    }
    
    
    // MARK: - Buttons Functionality
    @IBAction func addItemTapped(_ sender: Any) {
        
    }
    @IBAction func saveTappeed(_ sender: Any) {
        guard let name = nameField.text,
            !name.isEmpty else { return }
        
        if segue == "Item" {
            guard let description = descField.text else { return }
            itemController?.create(name: name, description: description)
            dismiss(animated: true, completion: nil)
            
        } else if segue == "Group" {
            groupController?.create(name: name, items: itemsToBeAdded)
            dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - Table View Functionality

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.existingItemsTableView {
            guard let itemsInController = itemController else { fatalError() }
            count = itemsInController.items.count
        } else if tableView == self.addedTableView {
            count = itemsToBeAdded.count
        }
        return count! // If this wasn't updated, break the app.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemController = itemController else { fatalError("No Item Controller somehow?") }
        var cell: UITableViewCell?
        
        if tableView == self.existingItemsTableView {
            
        guard let existingCells = tableView.dequeueReusableCell(withIdentifier: "ExistingItemsCell") as? ExistingItemsTableViewCell else { fatalError("Error Casting existing items cells.") }
            
            existingCells.item = itemController.items[indexPath.row]
            cell = existingCells
            
        } else if tableView == self.addedTableView {
            
            guard let addedCells = tableView.dequeueReusableCell(withIdentifier: "AddedItemsCell") as? AddedItemsTableViewCell else { fatalError("Error Casting Added items Cells") }
            
            addedCells.item = itemsToBeAdded[indexPath.row]
            cell = addedCells
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
