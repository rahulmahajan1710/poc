//
//  PBSingleton.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import UIKit

typealias PBCompletionHandler = (Bool , Any? , Error?) -> Void
typealias PBViewControllerCompletionHandler = (Bool , Error?) ->Void

class PBSingleton {
    //MARK:- Private Properties
    private let webServiceHelper = PBWebServiceHelper()
    
    //MARK:- Public Properties
    static let sharedInstance = PBSingleton()
    var pocList = Array<PBPoc>()
    var GITIssues = Array<PBGitIssue>()
  
    
    //MARK: - Web Call & Data Reading Methods

    func readPOCFromPlist(plistName : String , completion: (_ result : Bool , _ info : Dictionary<String, Any>?) -> Void ){
        if let path = Bundle.main.path(forResource: plistName , ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                var tempPOC : Array<PBPoc> = []
                var res  = PBConstants.KeyConstants.success
                do {
                    let pocs = dict[PBConstants.KeyConstants.pocListName] as! Array<Any>
                    for poc in pocs {
                        let pocDict = poc as! Dictionary<String,String>
                        let pocObj = PBPoc(pocName: pocDict[PBConstants.KeyConstants.pocName]!, storyboardName: pocDict[PBConstants.KeyConstants.pocStoryboard]!)
                        tempPOC.append(pocObj)
                    }
                    
                    if tempPOC.count>0 {
                        pocList = tempPOC
                    }
                    completion(res, nil)
                    
                } catch {
                    res = PBConstants.KeyConstants.failure
                    print("Handle \(error) here")
                    completion(res,[PBConstants.KeyConstants.status:error])
                }
            }
        }
    }
    
    //MARK:-  GIT Issues POC Web calls
    
    func getGITIssue(completion: @escaping PBViewControllerCompletionHandler) -> Void {
        webServiceHelper.fetchAllGitIssues { (result, data, error) in
            if result == true {
                let jsonData = data as! Array<[String: Any]>
                var temp = Array<PBGitIssue>()
                for gitIssueInfo in jsonData {
                    let issue = PBGitIssue(issueInfo: gitIssueInfo)
                    temp.append(issue)
                }
                if temp.count>0 {
                    self.GITIssues = temp.sorted{ $0.updateDate > $1.updateDate }
                    completion(true, nil)
                }
                else{
                    completion(false, error)
                }
            }
        }
    }
    
    func getCommentsOf(gitIssue : PBGitIssue , completion : @escaping PBViewControllerCompletionHandler) ->  Void{
        webServiceHelper.fetchCommentsWith(url: gitIssue.commentsURL) { (result, data, error) in
            if result == true {
                let jsonData = data as! Array<[String: Any]>
                var temp = Array<PBGitIssueComment>()
                for gitCommentInfo in jsonData {
                    let comment = PBGitIssueComment(commentInfo: gitCommentInfo)
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
