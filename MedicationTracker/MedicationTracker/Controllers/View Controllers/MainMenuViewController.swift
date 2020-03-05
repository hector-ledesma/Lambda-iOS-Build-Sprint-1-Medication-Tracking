//
//  MainMenuViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
//    var dayController: DayController?
    var itemController = ItemController.itemController
    var alertManager = AlertManager.alertManager
    var groupController = GroupController.groupController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "AddItemSegue" || segue.identifier == "CreateGroupSegue" {
            guard let detailVC = segue.destination as? DetailViewController else { fatalError("Failed Segue from main menu to Detail View" ) }
            // FIXME: Delete2
//            detailVC.dayController = self.dayController
            detailVC.itemController = self.itemController
            detailVC.groupController = self.groupController
            
            switch segue.identifier {
            case "AddItemSegue":
                detailVC.segue = .newItem
            case "CreateGroupSegue":
                detailVC.segue = .newGroup
            default:
                fatalError()
            }
            
        } else if segue.identifier == "ReminderSegue" {
            guard let alertsVC = segue.destination as? RemindersViewController else { fatalError("Failed Segue from main menu to Detail View" ) }
            // FIXME: Delete
//            alertsVC.dayController = self.dayController
            alertsVC.itemController = self.itemController
            alertsVC.groupController = self.groupController
            
        }
        
    }

}
