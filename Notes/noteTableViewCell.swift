//
//  noteTableViewCell.swift
//  Notes
//
//  Created by Sidharth Nayyar on 11/10/19.
//  Copyright © 2019 Sidharth Nayyar. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
