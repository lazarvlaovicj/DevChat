//
//  UserCell.swift
//  DevChat
//
//  Created by PRO on 4/29/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }
    
    func updateUI(user: Users) {
        firstName.text = user.firstName
    }
    
    func setCheckmark(selected: Bool) {
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

}
