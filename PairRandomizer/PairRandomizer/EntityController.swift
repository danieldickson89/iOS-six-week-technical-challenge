//
//  EntityController.swift
//  PairRandomizer
//
//  Created by Daniel Dickson on 3/11/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import Foundation
import CoreData

class EntityController {
    
    private let entityKey = "entity"
    static let sharedController = EntityController()
    
    // Create arrays for each category (and one for all combined)
    
    var entitiesList: [Entity] {
        
        
        let request = NSFetchRequest(entityName: "Entity")
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            let array = try moc.executeFetchRequest(request) as! [Entity]
            
            return array.sort() { $0.name < $1.name }
        
        } catch {
            return []
        }
    }

    var listOfNames: [String] = []
    
    func randomizeOrder() {
        
        for entity in entitiesList {
            listOfNames.append(entity.name!)
        }
        
        var count = 0
        for entity in listOfNames {
            print("\(entity) is being removed")
            self.listOfNames.removeAtIndex(count)
            self.listOfNames.insert(entity, atIndex: Int(arc4random_uniform(UInt32(listOfNames.count))))
            print("\(entity) is being inserted")
            count++
        }
    }
    
    func addEntity(entity: Entity) {
        
        self.saveToPersistence()
    }
    
    func removeEntity(entity: Entity) -> () {
        if let moc = entity.managedObjectContext {
            moc.deleteObject(entity)
        }
        saveToPersistence()
    }
    
    // Save Core Data
    func saveToPersistence() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving \(error)")
        }
    }
}

