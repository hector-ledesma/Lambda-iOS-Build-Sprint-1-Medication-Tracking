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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func itemDelete(_ sender: UIButton) {
    }
}
