//
//  MainScreenTableViewCell.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/3/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupCountLabel: UILabel!
    @IBAction func statusTapped(_ sender: UIButton) {
    }
    
    var identifier: Identifier? {
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
        guard let item = identifier as? Group else { return }
        groupNameLabel.text = item.name
        groupCountLabel.text = String(item.items.count)
        
    }

}
