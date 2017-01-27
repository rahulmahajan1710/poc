//
//  GHIssueMO+CoreDataClass.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import Foundation
import CoreData

@objc(GHIssueMO)
public class GHIssueMO: NSManagedObject {

    func setUpAttributes(with issueInfo : Dictionary<String, Any>) -> Void {
        title = (issueInfo[GHConstants.title] as! String)
        body  = (issueInfo[GHConstants.body] as! String)
        commentsURL = (issueInfo[GHConstants.commentsURL] as! String)
        updateDate = GHIssueMO.dateFromString(dateStr: issueInfo[GHConstants.updatedAt] as! String)
    }

    static func dateFromString(dateStr : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GHConstants.dateFormat
        return dateFormatter.date(from: dateStr)!
    }
    
}
