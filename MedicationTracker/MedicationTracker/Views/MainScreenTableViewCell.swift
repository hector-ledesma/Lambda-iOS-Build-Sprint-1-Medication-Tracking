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
    @IBOutlet weak var statusButton: UIButton!
    
    
    var identifier: Group? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView() {
        guard let identifier = identifier else { return }
        guard let groupIndex = GroupController.groupController.groups.firstIndex(of: identifier) else {return}
        let group = GroupController.groupController.groups[groupIndex]
        
        groupNameLabel.text = group.name
        groupCountLabel.text = "\(group.items.count)"
        var status: String
        switch group.status {
        case .standby:
            status = "Waiting"
        case .done:
            status = "Taken"
        case .cancelled:
            status = "Cancelled"
        case .skipped:
            status = "How did you get here?"
        }
        statusButton.setTitle(status, for: .normal)
        
    }
    
    // MARK: - Button Functionality
    @IBAction func statusTapped(_ sender: UIButton) {
        guard let group = identifier as? Group else { return }
        switch group.status {
            case .standby:
                group.status = .done
            case .done:
                group.status = .cancelled
            case .cancelled:
                group.status = .standby
            case .skipped:
                print("Seriously how are you getting here?")
            }
        updateView()
        }

}
