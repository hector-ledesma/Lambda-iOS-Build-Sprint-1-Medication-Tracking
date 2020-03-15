//
//  AllItemsViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/5/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class AllItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var allItemsTableView: UITableView!
    
    var itemController = ItemController.itemController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allItemsTableView.delegate = self
        allItemsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemController.loadFromPersistentStore()
        allItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemController.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllltemsCell") as? AllViewTableViewCell else { fatalError() }
        cell.itemsNameLabel.text = itemController.items[indexPath.row].name
        cell.buttonAction = { (cell) in
            guard let deleteItemIndex = self.itemController.items.firstIndex(of: self.itemController.items[indexPath.row]) else { fatalError() }
            self.itemController.items.remove(at: deleteItemIndex)
            self.itemController.saveToPersistentStore()
            self.allItemsTableView.reloadData()
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItemSegue" {
            guard let editVC = segue.destination as? EditItemViewController,
                let indexPath = allItemsTableView.indexPathForSelectedRow else { fatalError() }
            
            editVC.item = itemController.items[indexPath.row]
            
        }
    }
    
    



}
