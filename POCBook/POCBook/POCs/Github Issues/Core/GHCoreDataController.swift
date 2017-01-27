//
//  GHCoreDataController.swift
//  POCBook
//
//  Created by rahul mahajan on 18/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit
import CoreData



typealias GHCoreDataCompletionHandler = (Bool, [Any]?, Error?) -> Void

class GHCoreDataController: NSObject {
    //MARK:- Public Properties
    static let sharedInstance = GHCoreDataController()
    
    //MARK:- Private Properties
    private let coreDataQueue = DispatchQueue(label :  GHConstants.kCoreDataQueueName , qos: DispatchQoS.utility)
    private let managedObjectContext : NSManagedObjectContext
    private let mainMOC : NSManagedObjectContext? = nil
    private let privateMOC : NSManagedObjectContext? = nil
    
    override init() {
        guard let modelURL = Bundle.main.path(forResource: GHConstants.kModelFileName , ofType: "momd") else {
            fatalError(GHConstants.kModelFileLoadingError)
        }
        guard let mom = NSManagedObjectModel(contentsOf: URL(string: modelURL)!) else {
            fatalError("\(GHConstants.kMOMInitializationError) from \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        coreDataQueue.async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docURL = urls[urls.endIndex-1]
            let storeURL = docURL.appendingPathComponent("\(GHConstants.kModelFileName).sqlite")
            
            do{
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            }
            catch{
                fatalError("Error Adding Persistent Store: \(error)")
            }
        }
    }
    
    
    func fetchData(entityName: String , sortDescriptors : [NSSortDescriptor]? , completion : @escaping GHCoreDataCompletionHandler) -> Void {
        
        coreDataQueue.async {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:entityName)
            if let sortDescs = sortDescriptors {
                fetchRequest.sortDescriptors = sortDescs
            }
            do{
                let issueList = try self.managedObjectContext.fetch(fetchRequest)
                if !issueList.isEmpty{
                    completion(true , issueList , nil)
                }
                else{
                    completion(true , nil , nil)
                }
            }
            catch{
                print("Could not fetch issue list, \(error)")
                completion(false , nil , error)
            }
        }
    }
    
    func saveChanges() -> Void {
        coreDataQueue.sync {
            do{
                try managedObjectContext.save()
            }
            catch{
                print(error)
            }
        }
    }
    
    func insertEntityWith( name : String) -> NSManagedObject {
        let entityDesc = NSEntityDescription.entity(forEntityName: name, in: managedObjectContext)
        return NSManagedObject(entity: entityDesc!, insertInto: managedObjectContext)
    }

}
