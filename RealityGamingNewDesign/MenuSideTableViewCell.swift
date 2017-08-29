//
//  MenuSideTableViewCell.swift
//  RealityGamingNewDesign
//
//  Created by RealityGaming on 13/07/2017.
//  Copyright © 2017 MarentDev. All rights reserved.
//

import UIKit

class MenuSideTableViewCell: UITableViewCell {

    @IBOutlet weak var viewselect: UIView!//ON: 2769B0
    @IBOutlet weak var Fa: UILabel!
    @IBOutlet weak var Titre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
