//
//  GHIssueComment.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class GHIssueComment: NSObject {
    let userName : String
    let body : String
    
    init(commentInfo : Dictionary<String,Any>) {
        body = commentInfo[PBConstants.GITIssues.body]! as! String
        let userInfo = commentInfo[PBConstants.GITIssues.userName] as! Dictionary<String,Any>
        userName = userInfo[PBConstants.GITIssues.login] as! String
    }
    
}
