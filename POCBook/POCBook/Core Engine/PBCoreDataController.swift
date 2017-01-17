//
//  PBCoreDataController.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

typealias PBCoreDataCompletionHanlder = (Bool, Error?) -> Void

class PBCoreDataController: NSObject {

    //MARK:- Public Properties
    let sharedInstance = PBCoreDataController()
    
    //MARK:- Private Properties
    let coreDataQueue = DispatchQueue(label : "com.pocbook.coredataqueue" , qos: DispatchQoS.utility)
    
    
    
    
}
