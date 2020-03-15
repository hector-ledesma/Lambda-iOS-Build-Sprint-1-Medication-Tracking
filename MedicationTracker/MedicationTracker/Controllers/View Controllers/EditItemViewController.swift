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
    
    @IBOutlet weak var itemNameField: UITextField!
    // TODO: Make create item view a text view as well
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var groupsTableView: UITableView!
    
    // MARK: - Properties
    var item: Item?
    var delegate: AllItemsViewController?
    
    var itemController = ItemController.itemController
       var groupController = GroupController.groupController
       var alertManager = AlertManager.alertManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        
        if item != nil {
            updateViews()
        }
    }
    
    // MARK: - Methods
    
    func updateViews() {
        guard let item = item else { return }
        
        itemNameField.text = item.name
        descView.text = item.description
        
    }
    
    // Use this function to set delegates for the sake of keeping viewDidLoad cleaner.
    // TODO: Do this for other views
    func setDelegates() {
        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        descView.delegate = self
    }
    
    // Pass in the item that was loaded into the view, and find all groups where that item exists.
    func getGroups(for item: Item) -> [Group] {
        
        var groups: [Group] = []
        
        for group in groupController.groups {
            if let _ = group.items.firstIndex(of: item) {
                groups.append(group)
            }
        }
        
        return groups
    }
    
    // MARK: - Button Functionality

    @IBAction func saveButtonTapped(_ sender: Any) {
//        if let itemIndex = itemController.items.firstIndex(of: item!) {
//            guard let itemName = itemNameField.text,
//                !itemName.isEmpty,
//                let itemDescription = descView.text else { return }
//
//            itemController.items[itemIndex].name = itemName
//            itemController.items[itemIndex].description = itemDescription
//
//            self.dismiss(animated: true) { self.delegate?.allItemsTableView.reloadData()
//            }
        if let item = item {
        guard let itemName = itemNameField.text,
            !itemName.isEmpty,
            let itemDescription = descView.text else { return }
        
            item.name = itemName
            item.description = itemDescription
            
        
            itemController.saveToPersistentStore()
        self.dismiss(animated: true) { self.delegate?.allItemsTableView.reloadData()
        }
            
            
            
        }
    }
    
} // End of main class

// MARK: - Extensions

extension EditItemViewController: UITextViewDelegate {
    
}

extension EditItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getGroups(for: item!).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsForItemCell") as? GroupsForItemTableViewCell else { fatalError() }
        
        let group =  getGroups(for: item!)[indexPath.row]
        
        cell.groupNameLabel.text = group.name
        
        return cell
    }
    
    
}
