//
//  Entity.swift
//  PairRandomizer
//
//  Created by Daniel Dickson on 3/11/16.
//  Copyright © 2016 Daniel Dickson. All rights reserved.
//

import Foundation
import CoreData


class Entity: NSManagedObject {
    
    convenience init(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
    }
}

func == (lhs: Entity, rhs: Entity) -> Bool {
    return lhs.name == rhs.name
}

func > (lhs: Entity, rhs: Entity) -> Bool {
    return lhs.name < rhs.name
}