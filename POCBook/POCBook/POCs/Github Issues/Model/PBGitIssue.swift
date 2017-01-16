//
//  PBGitIssue.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class  PBGitIssue {
    let title : String
    let body : String
    let commentsURL : String
    let updateDate : Date
    var comments : Array<PBGitIssueComment>?
    
    
    init(issueInfo : Dictionary<String, Any>) {
        title = issueInfo[PBConstants.GITIssues.title] as! String
        body  = issueInfo[PBConstants.GITIssues.body] as! String
        commentsURL = issueInfo[PBConstants.GITIssues.commentsURL] as! String
        updateDate = PBGitIssue.dateFromString(dateStr: issueInfo[PBConstants.GITIssues.updatedAt] as! String)
    }
    
    static func dateFromString(dateStr : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = PBConstants.GITIssues.dateFormat
        return dateFormatter.date(from: dateStr)!
    }
}
