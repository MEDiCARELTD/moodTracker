//
//  TipCellControlTableViewCell.swift
//  MoodTracker
//
//  Created by App Camp on 20/08/2016.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit

class TipCellControlTableViewCell: UITableViewCell {
    
    @IBOutlet var cellImage: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
