//
//  GHIssueMO+CoreDataProperties.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import Foundation
import CoreData


extension GHIssueMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GHIssueMO> {
        return NSFetchRequest<GHIssueMO>(entityName: "GHIssue");
    }

    @NSManaged public var body: String?
    @NSManaged public var commentsURL: String?
    @NSManaged public var title: String?
    @NSManaged public var updateDate: Date?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension GHIssueMO {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: GHIssueCommentMO)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: GHIssueCommentMO)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
