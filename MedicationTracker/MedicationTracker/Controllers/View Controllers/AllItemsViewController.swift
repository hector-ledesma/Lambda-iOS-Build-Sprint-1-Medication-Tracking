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
        allItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemController.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllltemsCell") as? AllViewTableViewCell else { fatalError() }
        cell.itemsNameLabel.text = itemController.items[indexPath.row].name
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
