//
//  PBGitIssue.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

struct PBGitIssue {
    let title : String
    let body : String
    let commentsURL : String
    let updateDate : Date
    let comments : Array<PBGitIssueComment>?
    
    
    init(issueInfo : Dictionary<String, String>) {
        title = issueInfo[PBConstants.GITIssues.title]!
        body  = issueInfo[PBConstants.GITIssues.body]!
        commentsURL = issueInfo[PBConstants.GITIssues.commentsURL]!
        updateDate = PBGitIssue.dateFromString(dateStr: issueInfo[PBConstants.GITIssues.updatedAt]!)
        comments = nil
    }
    
    static func dateFromString(dateStr : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = PBConstants.GITIssues.dateFormat
        return dateFormatter.date(from: dateStr)!
    }
}
