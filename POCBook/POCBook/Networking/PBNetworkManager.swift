//
//  PBNetworkManager.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit


class PBNetworkManager: NSObject {

    //let dispatchQueue : DispatchQueue
    
    class var sharedInstance : PBNetworkManager {
        struct Singleton{
            static let instance = PBNetworkManager()
        }
        return Singleton.instance
    }
    
    
    
    
    lazy var mURLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    
    
    
    
}
