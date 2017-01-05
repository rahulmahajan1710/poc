//
//  PBGitIssueComment.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

struct PBGitIssueComment {
    let userName : String
    let body : String
    
    init(commentInfo : Dictionary<String,Any>) {
        body = commentInfo[PBConstants.GITIssues.body]! as! String
        let userInfo = commentInfo[PBConstants.GITIssues.userName] as! Dictionary<String,String>
        userName = userInfo[PBConstants.GITIssues.login]!
    }
    
}
