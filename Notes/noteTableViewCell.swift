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
        //style
        shadowView.layer.shadowColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2// 80% transparent
        shadowView.layer.cornerRadius = 2
        noteImage.layer.cornerRadius = 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    func configureCell(note: Note){
        self.noteNameLabel.text = note.noteName?.uppercased()//upper case is not necessory but looks good as title is always in uppercase
        self.DescriptionLabel.text = note.noteDescription
        
        self.noteImage.image = UIImage(data: note.noteImage! as Data)
    }
    

}
