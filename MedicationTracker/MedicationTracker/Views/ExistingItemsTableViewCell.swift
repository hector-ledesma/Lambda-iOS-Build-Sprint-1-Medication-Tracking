//
//  ExistingItemsTableViewCell.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/4/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class ExistingItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    var item: Item? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView() {
        guard let item = item else { return }
        itemNameLabel.text = item.name
        print(item.name)
        
    }

}
