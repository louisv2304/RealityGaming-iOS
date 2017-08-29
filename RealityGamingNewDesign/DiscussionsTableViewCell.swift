//
//  DiscussionsTableViewCell.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 22/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit

class DiscussionsTableViewCell: UITableViewCell {
    @IBOutlet weak var Titre: UILabel!
    @IBOutlet weak var Auteur: UILabel!
    @IBOutlet weak var forums: UILabel!
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Fa: UILabel!
    @IBOutlet weak var widthfa: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
