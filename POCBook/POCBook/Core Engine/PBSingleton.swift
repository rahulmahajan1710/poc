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
    private let webServiceHelper = PBWebServiceHelper.sharedInstance
    
    
    //MARK:- Public Properties
    static let sharedInstance = PBSingleton()
    var pocList = Array<PBPoc>()
    var rootViewController : UIViewController?
    
    //MARK:- Loading POCs
    func loadPOC( poc : PBPoc) -> Void {
        let pocDelegateClass = NSClassFromString(poc.pocDelegateClass) as? PBPOCDelegate.Type
        if let delegateClass = pocDelegateClass {
            let rootVC = rootViewController as! UINavigationController
            let pocObject = delegateClass.init()
            rootVC.pushViewController(pocObject.pocRootViewController(), animated:true)
        }
    }
    
    
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
                        let pocObj = PBPoc(pocInfo: pocDict)
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
    
  
    
    
}
