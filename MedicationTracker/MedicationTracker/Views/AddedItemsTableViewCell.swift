//
//  addedItemsTableViewCell.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/4/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class AddedItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var deleteItemButton: UIButton!
    
    var item: Item? {
        didSet {
            createView()
        }
    }
    
    var identifier: Item? {
        didSet {
            editView()
        }
    }
    var buttonAction: ((Any) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createView() {
        guard let item = item else { return }
        itemNameLabel.text = item.name
    }
    
    func editView() {
        guard let identifier = identifier else {  return }
        itemNameLabel.text = identifier.name
        deleteItemButton.isHidden = false
    }

    // MARK: - Buttons Functionality
    @IBAction func deleteItemTapped(_ sender: UIButton) {
        self.buttonAction?(sender)
    }
    
}
