//
//  ShoppingList.swift
//  Shopping List
//
//  Created by winston salcedo on 5/12/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    //MARK: Properties
    static var shoppingList: ShoppingList?
    
    //MARK: Singleton
    static let shared = ShoppingListController()
    
    let fetchedResultsController: NSFetchedResultsController<ShoppingList>
    
    init() {
        let fetchedRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false)]
        let resultsController: NSFetchedResultsController<ShoppingList> = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = resultsController
        fetchedResultsController.delegate = self as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultsController.performFetch()
        }catch {
            print("there was an error while retrieving the data \(error.localizedDescription)")
        }
    }
    
    //MARK: CRUD
    
    func addItem(name: String) {
        _ = ShoppingList(name: name, isComplete: false)
        //save to persistent Store
        saveToPersistentStore()
    }
    func deleteItem(shoppingList: ShoppingList){
        CoreDataStack.context.delete(shoppingList)
        //save to persistent data Store
        saveToPersistentStore()
    }
    //MARK: Methods
    func markComplete(shoppingList: ShoppingList) {
        if shoppingList.isComplete == true {
            shoppingList.isComplete = false
            
        }else {
            shoppingList.isComplete = true
        }
        //save to persistent Store
        saveToPersistentStore()
    }
    //MARK: save the data from the stack to the persistent Store
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
            
        }catch {
            print("There was an error while saving your data \(error.localizedDescription)")
        }
    }
}
