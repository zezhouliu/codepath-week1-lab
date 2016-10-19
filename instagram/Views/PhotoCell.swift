//
//  PhotoCell.swift
//  instagram
//
//  Created by Alex Liu on 10/19/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet public weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
