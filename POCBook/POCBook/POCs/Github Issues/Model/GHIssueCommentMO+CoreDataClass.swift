//
//  GHIssueCommentMO+CoreDataClass.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import Foundation
import CoreData

@objc(GHIssueCommentMO)
public class GHIssueCommentMO: NSManagedObject {

    func setUpAttributes(with commentInfo : Dictionary<String,Any>) -> Void {
        body = (commentInfo[GHConstants.body]! as! String)
        let userInfo = (commentInfo[GHConstants.userName] as! Dictionary<String,Any>)
        userName = (userInfo[GHConstants.login] as! String )
    }
}
