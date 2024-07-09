//
//  CustomTableViewCell.swift
//  DemoCoreData
//
//  Created by Arjun on 10/02/21.
//  Copyright © 2021 Arjun. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "CustomTableViewCell"
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbDepartment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
