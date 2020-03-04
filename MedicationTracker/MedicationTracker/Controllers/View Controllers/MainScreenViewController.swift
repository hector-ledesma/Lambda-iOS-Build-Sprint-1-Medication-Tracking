//
//  MainScreenViewController.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    let dayController = DayController()
    let itemController = ItemController()
    let groupController = GroupController()
    let alertManager = AlertManager()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MainScreenViewController.swift" {
            guard let mainMenuVC = segue.destination as? MainMenuViewController else { fatalError("Segue to MainMenu failed.") }
            
            mainMenuVC.dayController = self.dayController
            mainMenuVC.itemController = self.itemController
            mainMenuVC.groupController = self.groupController
            mainMenuVC.alertManager = self.alertManager
        }
        
    }

}


// MARK: - Table View Methods

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell") as? MainScreenTableViewCell else { fatalError("Could not convert items to cells") }
        
        print(indexPath.row)
        cell.identifier = groupController.groups[indexPath.row]
        
        
        return cell
    }
    
    
}
