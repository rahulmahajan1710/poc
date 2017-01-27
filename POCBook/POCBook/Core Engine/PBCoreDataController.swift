//
//  PBCoreDataController.swift
//  POCBook
//
//  Created by rahul mahajan on 17/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit
import CoreData

let kCoreDataQueueName       = "com.pocbook.coredataqueue"
let kModelFileName           = "GitHubIssues"
let kModelFileLoadingError   = "Error loading model from bundle"
let kMOMInitializationError  = "Error Initializing MOM"

typealias PBCoreDataCompletionHandler = (Bool, Error?) -> Void

class PBCoreDataController: NSObject {

    //MARK:- Public Properties
    let sharedInstance = PBCoreDataController()
    let managedObjectContext : NSManagedObjectContext
    
    //MARK:- Private Properties
    let coreDataQueue = DispatchQueue(label : kCoreDataQueueName , qos: DispatchQoS.utility)
    
    
    override init() {
        guard let modelURL = Bundle.main.path(forResource: kModelFileName , ofType: "momd") else {
            fatalError(kModelFileLoadingError)
        }
        guard let mom = NSManagedObjectModel(contentsOf: URL(string: modelURL)!) else {
            fatalError("\(kMOMInitializationError) from \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        coreDataQueue.async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex-1]
            let storeURL = docURL.appendingPathComponent("\(kModelFileName).sqlite")
            
            do{
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            }
            catch{
                fatalError("Error Adding Persistent Store: \(error)")
            }
        }
    }
    
}
