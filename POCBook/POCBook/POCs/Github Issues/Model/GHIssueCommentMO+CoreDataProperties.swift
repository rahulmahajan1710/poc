//
//  GHIssueCommentMO+CoreDataProperties.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import Foundation
import CoreData


extension GHIssueCommentMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GHIssueCommentMO> {
        return NSFetchRequest<GHIssueCommentMO>(entityName: "GHIssueComment");
    }

    @NSManaged public var userName: String?
    @NSManaged public var body: String?
    @NSManaged public var issue: GHIssueMO?

}
