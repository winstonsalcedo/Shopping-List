//
//  CoreDataStack.swift
//  Shopping List
//
//  Created by winston salcedo on 5/12/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "Shopping_List")
        persistentContainer.loadPersistentStores(completionHandler: { ( _, error) in
            if let srror = error {
                fatalError("Unresolved Error \(String(describing: error))")
            }
        })
        return persistentContainer
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}

