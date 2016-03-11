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
            
            return array.shuffle()
            //return array.sort() { $0.name < $1.name }
        
        } catch {
            return []
        }
    }
    
//    var listOfNames: [String] {
//        var array: [String] = []
//        for entity in entitiesList {
//            array.append(entity.name!)
//        }
//        return array.shuffle()
//    }
    
//    func randomizeOrder() {
//        self.listOfNames.shuffle()
//    }
    
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

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

