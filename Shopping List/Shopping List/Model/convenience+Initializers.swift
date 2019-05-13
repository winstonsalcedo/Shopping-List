 //  convenience+Initializers.swift
//  Shopping List
//
//  Created by winston salcedo on 5/12/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import Foundation
import CoreData
 
 extension ShoppingList {
    
    convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.isComplete = isComplete
    }
    
 }
