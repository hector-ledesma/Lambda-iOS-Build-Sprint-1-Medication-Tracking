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
    
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var addedTableView: UITableView!
    @IBOutlet weak var existingItemsTableView: UITableView!
    
    
    
    var dayController: DayController?
    var itemController: ItemController?
    var groupController: GroupController?
    var alertManager: AlertManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addItemTapped(_ sender: Any) {
    }
    @IBAction func saveTappeed(_ sender: Any) {
    }
    

}
