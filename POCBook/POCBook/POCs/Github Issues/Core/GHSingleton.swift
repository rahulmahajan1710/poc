//
//  GHSingleton.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class GHSingleton: NSObject {
    
    //MARK:- Private Properties
    private let webServiceHelper = PBWebServiceHelper.sharedInstance
    
    //MARK:- Public Properties
    static let sharedInstance = GHSingleton()
    var issues = Array<GHIssue>	()
    
    //MARK:-  GIT Issues POC Web calls
    
    func getGITIssue(completion: @escaping PBViewControllerCompletionHandler) -> Void {
        webServiceHelper.fetchAllGitIssues { (result, data, error) in
            if result == true {
                let jsonData = data as! Array<[String: Any]>
                var temp = Array<GHIssue>()
                for gitIssueInfo in jsonData {
                    let issue = GHIssue(issueInfo: gitIssueInfo)
                    temp.append(issue)
                }
                if temp.count>0 {
                    self.issues = temp.sorted{ $0.updateDate > $1.updateDate }
                    completion(true, nil)
                }
                else{
                    completion(false, error)
                }
            }
        }
    }
    
    func getCommentsOf(gitIssue : GHIssue , completion : @escaping PBViewControllerCompletionHandler) ->  Void{
        webServiceHelper.fetchCommentsWith(url: gitIssue.commentsURL) { (result, data, error) in
            if result == true {
                let jsonData = data as! Array<[String: Any]>
                var temp = Array<GHIssueComment>()
                for gitCommentInfo in jsonData {
                    let comment = GHIssueComment(commentInfo: gitCommentInfo)
                    temp.append(comment)
                }
                if temp.count>0 {
                    gitIssue.comments = temp
                    completion(true, nil)
                }
                else{
                    completion(false, error)
                }
            }
            
        }
    }
    
    
    
}
