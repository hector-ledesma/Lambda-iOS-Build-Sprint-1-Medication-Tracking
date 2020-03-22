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
    var groupButtonAction : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func groupDelete(_ sender: UIButton) {
        groupButtonAction?()
    }
    
    @IBAction func itemDelete(_ sender: UIButton) {
        for group in groupController.groups {
            for item in group.items {
                if item.name == itemsNameLabel.text {
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
