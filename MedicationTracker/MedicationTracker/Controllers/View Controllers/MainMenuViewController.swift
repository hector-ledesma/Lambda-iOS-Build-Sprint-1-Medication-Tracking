//
//  MainMenuViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    var dayController: DayController?
    var itemController: ItemController?
    var groupController: GroupController?
    var alertManager: AlertManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItemSegue" || segue.identifier == "CreateGroupSegue" {
            guard let detailVC = segue.destination as? DetailViewController else { fatalError("Failed Segue from main menu to Detail View" ) }
            
            detailVC.dayController = self.dayController
            detailVC.itemController = self.itemController
            detailVC.groupController = self.groupController
            detailVC.alertManager = self.alertManager
            
            switch segue.identifier {
            case "AddItemSegue":
                detailVC.segue = "Item"
            case "CreateGroupSegue":
                detailVC.segue = "Group"
            default:
                fatalError()
            }
            
        }
        
    }

}
