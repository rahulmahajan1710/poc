//
//  PBWebServiceHelper.swift
//  POCBook
//
//  Created by rahul mahajan on 10/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class PBWebServiceHelper: NSObject {
    
    static let sharedInstance = PBWebServiceHelper()

    func fetchAllGitIssues(wsCompletion : @escaping PBCompletionHandler) -> Void {
        let nwRequest = PBNWRequest(url: PBConstants.GITIssues.gitIssuesURL, params: nil, tag: PBConstants.GITIssues.gitPocId, parseJson: true)
        PBNetworkManager.sharedInstance.send(request: nwRequest) { ( urlResponse, responseData, error) in
            if error != nil {
                wsCompletion( false , nil , error)
            }
            else{
                wsCompletion( true , responseData , nil)
            }
        }
    }
    
    func fetchCommentsWith( url : String , completion : @escaping PBCompletionHandler) -> Void {
        let nwRequest = PBNWRequest(url: url, params: nil, tag:PBConstants.GITIssues.gitPocId, parseJson: true)
        PBNetworkManager.sharedInstance.send(request: nwRequest) { (urlResponse, responseData, error) in
            if error != nil {
                completion( false , nil , error)
            }
            else{
                completion( true , responseData , nil)
            }
        }
    }
    
}
