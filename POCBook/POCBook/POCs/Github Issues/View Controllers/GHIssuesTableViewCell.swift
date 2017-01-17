//
//  GHIssuesTableViewCell.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class GHIssuesTableViewCell: UITableViewCell {

    //MARK:- IB Outlets
    @IBOutlet weak var issueNameLbl: UILabel!
    @IBOutlet weak var issueDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
