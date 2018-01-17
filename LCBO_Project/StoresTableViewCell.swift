//
//  StoresTableViewCell.swift
//  LCBO_Project
//
//  Created by Naga Sai Jyothi  on 2017-12-15.
//  Copyright © 2017 Naga Sai Jyothi . All rights reserved.
//

import UIKit

class StoresTableViewCell: UITableViewCell {

    @IBOutlet weak var storeInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
