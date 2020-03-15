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
    // TODO: Make create item view a text view as well
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
    
    // Pass in the item that was loaded into the view, and find all groups where that item exists.
    func getGroups(for item: Item) -> [Group] {
        
    }
    
    // MARK: - Button Functionality

    @IBAction func saveButtonTapped(_ sender: Any) {
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
