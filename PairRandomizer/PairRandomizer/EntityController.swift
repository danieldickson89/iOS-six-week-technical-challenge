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
            
            //return array
            return array.sort() { $0.name < $1.name }
        
        } catch {
            return []
        }
    }
    
    var randomEntities: [Entity] = []
    
    func randomizeList(list: [Entity]) {
        randomEntities = shuffleArray(entitiesList)
    }
    
    func shuffleArray<T>(var array: [T]) -> [T] {
        for index in (0..<array.count) {
            let randomIndex = Int(arc4random_uniform(UInt32(index)))
            (array[index], array[randomIndex]) = (array[randomIndex], array[index])
        }
        
        return array
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

