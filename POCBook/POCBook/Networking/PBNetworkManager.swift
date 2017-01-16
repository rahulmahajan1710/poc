//
//  PBNetworkManager.swift
//  POCBook
//
//  Created by rahul mahajan on 05/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

typealias PBNWManagerCompletionHandler = (_ result : Bool ,_ info : Data) -> Void

class PBNetworkManager {

    private let nwDispatchQueue : DispatchQueue
    
    init() {
        nwDispatchQueue = DispatchQueue(label: "com.pocbook.nwqueue", qos: DispatchQoS.utility)
    }
    
    class var sharedInstance : PBNetworkManager {
        struct Singleton{
            static let instance = PBNetworkManager()
        }
        return Singleton.instance
    }
    
    func send(request : PBNWRequest , completion : @escaping PBNWRequestCompletionHandler) -> Void {
        nwDispatchQueue.async {
            request.loadRequest(completion : completion)
        }
    }
    
    
}
