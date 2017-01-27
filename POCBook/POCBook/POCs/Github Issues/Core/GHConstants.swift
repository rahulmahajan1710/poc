//
//  GHConstants.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit


struct GHConstants {
    
static let kIssueListVC                = "Github Issues"
static let kIssueListCellIdentifier    = "GHIssuesTableViewCell"
static let kCommentsVCIdentifier       = "GHCommentsViewController"
static let kCoreDataQueueName          = "com.pocbook.githubissues.coredataqueue"
static let kModelFileName              = "GitHubIssues"
    
static let kModelFileLoadingError      = "Error loading model from bundle"
static let kMOMInitializationError     = "Error Initializing MOM"
static let kIssueEntity                = "GHIssue"
static let kCommentEntity              = "GHIssueComment"
    
static let kComments                   = "Comments"
static let kCommentsCellIdentifier     = "GHCommentsTableViewCell"
    
static let gitIssuesURL                = "https://api.github.com/repos/crashlytics/secureudid/issues"
static let commentsURL                 = "comments_url"
static let title                       = "title"
static let body                        = "body"
static let updatedAt                   = "updated_at"
static let dateFormat                  = "yyyy-MM-dd'T'HH:mm:ss'Z'"
static let userName                    = "user"
static let login                       = "login"
}

