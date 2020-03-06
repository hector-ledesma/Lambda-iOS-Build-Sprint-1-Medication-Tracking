//
//  AllViewTableViewCell.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/5/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class AllViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemsNameLabel: UILabel!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupCountLabel: UILabel!
    
    var itemController = ItemController.itemController
    var groupController = GroupController.groupController
    
    var buttonAction : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func itemDelete(_ sender: UIButton) {
        for group in groupController.groups {
            for item in group.items {
                if item.name == itemsNameLabel.text {
                    print("Found item in group: \(group.name)")
                    guard let indexToDelete = group.items.firstIndex(of: item) else { fatalError() }
                    print("Will delete item: \(group.items[indexToDelete].name)")
                    group.items.remove(at: indexToDelete)
                }
            }
        }
        groupController.saveToPersistentStore()
        guard let button = buttonAction else { fatalError() }
        button(self)
        
    }
}
