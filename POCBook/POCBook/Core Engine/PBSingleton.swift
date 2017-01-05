//
//  PBSingleton.swift
//  POCBook
//
//  Created by rahul mahajan on 23/12/16.
//  Copyright © 2016 rahul mahajan. All rights reserved.
//

import UIKit

class PBSingleton {
    static let sharedInstance = PBSingleton()
    
    var pocList : Array<PBPoc>
    
    init() {
        pocList = []
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
    
    
    
    
}
