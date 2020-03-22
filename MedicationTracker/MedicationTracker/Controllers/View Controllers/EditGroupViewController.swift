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
    
    var group: Group? {
        didSet {
            itemsInGroup = group!.items
        }
    }
    var itemsInGroup: [Item] = []
    
    // MARK: - Controllers
    
    var alertManager = AlertManager.alertManager
    var groupController = GroupController.groupController
    var itemController = ItemController.itemController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        updateViews()
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        guard let group = group else { return }
        self.groupNameLabel.text = group.name
        existingItemsTableView.reloadData()
        addedItemsTableView.reloadData()
    }
    
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
        var count: Int = 0
        if tableView == addedItemsTableView {
//            count = self.group!.items.count
            count = self.itemsInGroup.count
        } else if tableView == existingItemsTableView {
            count = self.itemController.items.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == addedItemsTableView {
            guard let addedItem = tableView.dequeueReusableCell(withIdentifier: "AddedItemsCell") as? AddedItemsTableViewCell else { return cell}
            
//            addedItem.item = self.group?.items[indexPath.row]
            addedItem.item = self.itemsInGroup[indexPath.row]
            
            addedItem.buttonAction = { something in
                
                self.remove(item: self.itemsInGroup[indexPath.row])
                
            }
            
            cell = addedItem
        } else if tableView == existingItemsTableView {
            guard let existingItem = tableView.dequeueReusableCell(withIdentifier: "ExistingItemsCell") as? ExistingItemsTableViewCell else { return cell}
            
            existingItem.item = itemController.items[indexPath.row]
            
            cell = existingItem
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == existingItemsTableView {
            if let _ = self.itemsInGroup.firstIndex(of: itemController.items[indexPath.row]) {
                print("Item already exists")
            } else { self.itemsInGroup.append(itemController.items[indexPath.row])
                addedItemsTableView.reloadData()
            }
        }
    }
    
    
    private func remove(item: Item) {
        itemsInGroup.removeAll(where: { $0 == item })
        addedItemsTableView.reloadData()
    }
    
}
