//
//  ListsTableViewCell.swift
//  FrameworksAssign4
//
//  Created by Manoj on 2021-03-28.

import UIKit

class ListsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDataTime: UILabel!
    @IBOutlet weak var imgSentiment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
