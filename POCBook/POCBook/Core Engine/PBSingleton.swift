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

    func readPOCFromPlist(plistName : String , completion: (_ result : Bool , _ info : Dictionary<String, Any>?) -> Void ){
        
        
        if let path = Bundle.main.path(forResource: plistName , ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                var tempPOC : Array<PBPoc> = []
                var res  = PBConstants.KeyConstants.success
                do {
                    let pocs = dict[PBConstants.KeyConstants.pocListName] as! Array<Any>
                    for poc in pocs {
                        let pocDict = poc as! Dictionary<String,String>
                        let pocObj = PBPoc(pocName: pocDict[PBConstants.KeyConstants.pocName]!, controllerName: pocDict[PBConstants.KeyConstants.pocController]!)
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
        
//        var tempPOC : Array<PBPoc> = []
//        var res  = PBConstants.KeyConstants.success
//        do {
//            let data = try Data(contentsOf: URL(string : plistPath!)!)
//            
//            let pocInfo = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String : Any]
//        
//            let pocs = pocInfo[PBConstants.KeyConstants.pocListName] as! Array<Any>
//            for poc in pocs {
//                let pocDict = poc as! Dictionary<String,String>
//                let pocObj = PBPoc(pocName: pocDict[PBConstants.KeyConstants.pocName]!, controllerName: pocDict[PBConstants.KeyConstants.pocController]!)
//                tempPOC.append(pocObj)
//            }
//            
//            if tempPOC.count>0 {
//                pocList = tempPOC
//            }
//            completion(res, nil)
//            
//        } catch {
//            res = PBConstants.KeyConstants.failure
//            print("Handle \(error) here")
//            completion(res,[PBConstants.KeyConstants.status:error])
//        }
        
    }
    
}
