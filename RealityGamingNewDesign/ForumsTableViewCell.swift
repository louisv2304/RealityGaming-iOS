//
//  ForumsTableViewCell.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 16/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit

class ForumsTableViewCell: UITableViewCell {

    @IBOutlet weak var Nodeicon: UIImageView!
    @IBOutlet weak var Titre: UILabel!
    @IBOutlet weak var Divers: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
