//
//  RemindersTableViewCell.swift
//  MedicationTracker
//
//  Created by Karen Rodriguez on 3/4/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class RemindersTableViewCell: UITableViewCell {

    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var isActiveButton: UIButton!
    
    var alert: Alert? {
        didSet {
            updateViews()
        }
    }
    
    var btnAction: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods Functionality
    func updateViews() {
        guard let alert = alert else { return }
        
        identifierLabel.text = alert.group?.name
        whenLabel.text = "Daily"
        isActiveButton.setTitle(alert.isActive ? "Active" : "Inactive" , for: .normal)
        
        
    }

    // MARK: - Button Functionality
    @IBAction func isActiveTapped(_ sender: Any) {
        if var alert = alert {
            alert.isActive.toggle()
            print("alert toggle hit: \(alert.isActive)")
            savePersistence()
            updateViews()
        }
    }
    
    
    func savePersistence() {
        ItemController.itemController.saveToPersistentStore()
        GroupController.groupController.saveToPersistentStore()
        AlertManager.alertManager.saveToPersistentStore()
        
    }
}
