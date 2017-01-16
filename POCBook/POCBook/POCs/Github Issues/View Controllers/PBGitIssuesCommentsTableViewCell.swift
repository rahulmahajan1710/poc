//
//  PBGitIssuesCommentsTableViewCell.swift
//  POCBook
//
//  Created by rahul mahajan on 16/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class PBGitIssuesCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
